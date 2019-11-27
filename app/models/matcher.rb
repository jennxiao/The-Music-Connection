require 'munkres'

# This class contains all the logic for matching students to teachers and tutors
class Matcher
  @@MAX_WEIGHT = 1000
  mattr_accessor :MAX_WEIGHT

  class << self
  
    def calculate
      a, m1, m2, m3 = get_matches
      b = run_matches(a, m1, m2, m3)
      return b
    end

    private
    # Generate every possible pairing
    # and return corresponding matrix
    def get_matches
      Match.where(forced: false).delete_all
      tutor_index = {}
      teacher_index = {}
      parent_index = {}
      a = Tutor.order("id ASC").all
      b = Teacher.order("id ASC").all
      c = Parent.order("id ASC").all
      d = Match.order("id ASC").all
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
        matrix.each do |r, i|
          matrix[i].push(0)
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
        if match.teacher.nil?
          col = parent_index[match.parent]
        else
          col = teacher_index[match.teacher]
        end
        matrix.each do |en, i|
          matrix[i][col] = 0
        end
        matrix[r].each do |en, i|
          matrix[r][i] = 0
        end
        matrix[r][col] = @@MAX_WEIGHT
      end
      return matrix, 
             tutor_index, 
             teacher_index, 
             parent_index
    end

    def run_matches(matrix, tutor_index, teacher_index, parent_index)
      matrix_deep_copy = Marshal.load(Marshal.dump(matrix))
      m = Munkres.new(matrix, 2)
      optimal = m.find_pairings
      optimal.each do |pairing|
        row_id = pairing[0]
        column_id = pairing[1]
        ma = Match.new

        if !teacher_index[column_id].nil?
          ma.attributes = {
            tutor: Tutor.find_by(id: tutor_index[row_id]),
            teacher: Teacher.find_by(id: teacher_index[column_id]),
            parent: nil,
            forced: false,
            score: matrix_deep_copy[row_id][column_id]
          }
        else 
          ma = Match.new
          ma.attributes = {
            tutor: Tutor.find_by(id: tutor_index[row_id]),
            teacher: nil,
            parent: Parent.find_by(id: parent_index[column_id]),
            forced: false,
            score: matrix_deep_copy[row_id][column_id]
          }
        end
        ma.save
      end
      return Match.all
    end

    def heuristic(tutor, teacher, parent)
      if parent.nil?
        return 10
      else 
        return 10
      end
    end
  end

end
