# frozen_string_literal: true
require 'munkres'

# All logic for matching tutors to students
class Matcher
  @@MAX_WEIGHT = 1000
  mattr_accessor :MAX_WEIGHT

  class << self
    def calculate
      a, m1, m2, m3 = generate_matrix
      run_matches(a, m1, m2, m3)
    end

    private
    # Generate every possible pairing
    # and return corresponding matrix
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
      if parent.nil?
        10
      else
        10
      end
    end
  end
end
