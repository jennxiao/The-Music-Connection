# frozen_string_literal: true

require 'munkres'
# All logic for matching tutors to students
class Matcher
  @@MAX_WEIGHT = 10000
  mattr_accessor :MAX_WEIGHT

  class << self
    def calculate
      a, m1, m2, m3 = generate_matrix
      return run_matches(a, m1, m2, m3) unless a.empty?

      []
    end

    private

    # (Re)generate and calculate a score for every tutor/student pairing.
    #
    # Deletes recalculates all Matches in the database that are not "forced"
    # i.e. set by manual matching.
    #
    # Returns a matrix indexed by (tutor, student) and the hashes that
    # maps (matrix index => client ID) for tutor, teacher, parent respectively.
    # rubocop:disable MethodLength
    def generate_matrix
      Match.where(forced: false).delete_all
      tutor_index = {}
      teacher_index = {}
      parent_index = {}
      a = Tutor.order('id ASC').all
      b = Teacher.order('id ASC').all
      c = Parent.order('id ASC').all
      d = Match.order('id ASC').all
      matrix = []
      if Tutor.count + Teacher.count + Parent.count == 0
        return [matrix, {}, {}, {}]
      end

      a.each do |tutor|
        row = []
        b.each do |teacher|
          teacher_index[row.length] = teacher.id
          row.push(heuristic(tutor, teacher, nil))
        end
        c.each do |parent|
          parent_index[row.length] = parent.id
          row.push(heuristic(tutor, nil, parent))
        end
        tutor_index[matrix.length] = tutor.id
        matrix.push(row)
      end

      # Pad matrix to square (required by munkres library)
      while matrix.length > matrix[0].length
        matrix.each do |r|
          r.push(0)
        end
      end
      while matrix.length < matrix[0].length
        r = []
        matrix[0].each do
          r.push(0)
        end
        matrix.push(r)
      end

      # Set manual matching weights
      d.each do |match|
        r = tutor_index[match.tutor]
        col = -1
        col = if match.teacher.nil?
                parent_index[match.parent]
              else
                teacher_index[match.teacher]
              end
        matrix.each do |_en, i|
          matrix[i][col] = 0
        end
        matrix[r].each do |_en, i|
          matrix[r][i] = 0
        end
        matrix[r][col] = @@MAX_WEIGHT
      end
      [matrix,
       tutor_index,
       teacher_index,
       parent_index]
    end

    # rubocop:enable MethodLength
    # Wrapper method for munkres. Saves results in Matches database.
    def run_matches(matrix, tutor_index, teacher_index, parent_index)
      matrix_deep_copy = Marshal.load(Marshal.dump(matrix))
      m = Munkres.new(matrix, 2)
      optimal = m.find_pairings
      optimal.each do |pairing|
        row_id = pairing[0]
        column_id = pairing[1]
        ma = Match.new
        ma.attributes = {
          tutor: Tutor.find_by(id: tutor_index[row_id]),
          teacher: Teacher.find_by(id: teacher_index[column_id]),
          parent: Parent.find_by(id: parent_index[column_id]),
          forced: false,
          score: matrix_deep_copy[row_id][column_id]
        }
        ma.save
      end
      Match.all
    end

    # Determines the score assigned to a tutor-student pairing
    def heuristic(tutor, teacher, parent)
      if !parent.nil?
        overlapping_time = 0

        tutor_instruments = tutor[:instrument].split(',')
        parent_instruments = parent[:instrument].split(',')

        tutor_instruments.each do |i1|
          parent_instruments.each do |i2|
            overlapping_time += 40 if i1 == i2
          end
        end


        preferred_grades = tutor[:preferred_grade].split(',')
        preferred_grades.each do |x|
          x = x.to_i
        end
        puts preferred_grades.inspect
        student_grade = parent[:grade].to_i
        puts "K".to_i

        preferred_grades.each do |g|
          overlapping_time += 5 if g == student_grade
        end

        # this section makes assumption that none of the availabilities for a person overlaps with their other availabilities
        Availability.deserialize(parent[:availabilities]).each do |a|
          max_overlap = 0
          Availability.deserialize(tutor[:availabilities]).each do |b|
            overlap = Availability.overlap(a, b).div(60)
            max_overlap = overlap if overlap > max_overlap
          end
          overlapping_time += max_overlap
        end

        overlapping_time += 5 if parent[:past_app]
        overlapping_time += 8 if parent[:lunch]
        overlapping_time += 10 if parent[:matched_before]

        # puts "Parent:"
        # puts overlapping_time
        overlapping_time
      else
        overlapping_time = 0

        tutor_instruments = tutor[:instrument].split(',')
        teacher_instruments = teacher[:instrument].split(',')

        tutor_instruments.each do |i1|
          teacher_instruments.each do |i2|
            overlapping_time += 40 if i1 == i2
          end
        end

        preferred_grades = tutor[:preferred_grade].split(',')
        preferred_grades.each do |x|
          x = x.to_i
        end
        puts preferred_grades.inspect

        teacher_grades = teacher[:grade].split(',')
        preferred_grades.each do |x|
          x = x.to_i
        end
        puts preferred_grades.inspect
        actual_grade = teacher[:grade].to_i

        preferred_grades.each do |g1|
          teacher_grades.each do |g2|
            overlapping_time += 5 if g1 == g2
          end
        end

        # this section makes assumption that none of the availabilities for a person overlaps with their other availabilities
        Availability.deserialize(teacher[:availabilities]).each do |a|
          max_overlap = 0
          Availability.deserialize(tutor[:availabilities]).each do |b|
            overlap = Availability.overlap(a, b).div(60)
            max_overlap = overlap if overlap > max_overlap
          end
          overlapping_time += max_overlap
        end

        # puts "Teacher:"
        # puts overlapping_time
        overlapping_time
      end
    end
  end
end
