class Match < ActiveRecord::Base
  belongs_to :tutor, foreign_key: :tutors_id
  belongs_to :teacher, foreign_key: :teachers_id
  belongs_to :parent, foreign_key: :parents_id

  validates :score,   presence: true, 
                      numericality: {   
                        :only_integer => true,
                        :less_than_or_equal_to => 1000,
                        :greater_than_or_equal_to => 0
                      }
  validates :forced,  inclusion: { in: [true, false] }

  validate :one_tutor_one_student
  
  def one_tutor_one_student
    if tutor.nil?
      errors.add(:tutor, "Tutor missing in match")
    end
    if teacher.nil? && parent.nil?
      errors.add(:teacher, "Student missing in match")
    end
    if !teacher.nil? && !parent.nil?
      errors.add(:teacher, "Two students present in match (must be one to one)")
    end
  end
  
end
