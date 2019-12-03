# frozen_string_literal: true

require 'munkres'
# All logic for matching tutors to students
class Matcher
  @@MAX_WEIGHT = 10000
  mattr_accessor :MAX_WEIGHT

  class << self
    def calculate
      a, m1, m2, m3 = generate_matrix
      run_matches(a, m1, m2, m3)
    end

    private

    # Generate every possible pairing
    # and return corresponding matrix
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
      matrix = [] # Index by (tutor, student)
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

      # padding to square
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

    # Determine the score assigned to a tutor-student pairing
    # TODO: Implement this properly
    def heuristic(tutor, teacher, parent)
      if !parent.nil?
        overlapping_time = 0

        #preferred grade is of the form "Grade 9-12" so want to get out that digits 9 and 12
        lower_grade = tutor[:preferred_grade][6].to_i
        higher_grade = tutor[:preferred_grade][8].to_i
        if !(tutor[:preferred_grade][9] == nil)
          higher_grade = higher_grade * 10 + tutor[:preferred_grade][9].to_i
        end
        actual_grade = parent[:grade].to_i

        while lower_grade <= higher_grade
          if actual_grade == lower_grade
            overlapping_time += 15
          end
          lower_grade += 1
        end

        # this section makes assumption that none of the availabilities for a person overlaps with their other availabilities
        Availability.deserialize(parent[:availabilities]).each do |a|
          max_overlap = 0
          Availability.deserialize(tutor[:availabilities]).each do |b|
            overlap = Availability.overlap(a, b).div(60)
            if overlap > max_overlap
              max_overlap = overlap
            end
          end
          overlapping_time += max_overlap
        end

        if parent[:past_app]
          overlapping_time += 5
        end
        if parent[:lunch]
          overlapping_time += 8
        end
        if parent[:matched_before]
          overlapping_time += 10
        end

        puts "Parent:"
        puts overlapping_time
        return overlapping_time
      else
        overlapping_time = 0

        #preferred grade is of the form "Grade 9-12" so want to get out that digits 9 and 12
        lower_grade = tutor[:preferred_grade][6].to_i
        higher_grade = tutor[:preferred_grade][8].to_i
        if !(tutor[:preferred_grade][9] == nil)
          higher_grade = higher_grade * 10 + tutor[:preferred_grade][9].to_i
        end
        actual_grade = teacher[:grade].to_i

        while lower_grade <= higher_grade
          if actual_grade == lower_grade
            overlapping_time += 15
          end
          lower_grade += 1
        end

        # this section makes assumption that none of the availabilities for a person overlaps with their other availabilities
        Availability.deserialize(teacher[:availabilities]).each do |a|
          max_overlap = 0
          Availability.deserialize(tutor[:availabilities]).each do |b|
            overlap = Availability.overlap(a, b).div(60)
            if overlap > max_overlap
              max_overlap = overlap
            end
          end
          overlapping_time += max_overlap
        end

        puts "Teacher:"
        puts overlapping_time
        return overlapping_time
      end
    end
  end
end
