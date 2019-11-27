class Match < ActiveRecord::Base
  belongs_to :tutor, foreign_key: :tutors_id
  belongs_to :teacher, foreign_key: :teachers_id
  belongs_to :parent, foreign_key: :parents_id

  validates :score,   presence: true, 
                      numericality: {   
                        :only_integer => true,
                        :greater_than_or_equal_to => 0
                      }
  validates :forced,  inclusion: { in: [true, false] }

  validate :one_tutor_one_student
  validate :max_score_cap_validator
  
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
  
  def max_score_cap_validator
    Matcher.MAX_WEIGHT + 1
    if score > Matcher.MAX_WEIGHT
      errors.add(:score, "Score value too high")
    end
  end
  
end
