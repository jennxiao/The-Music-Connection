class Teacher < ActiveRecord::Base
  include ContactValidation
  
  validates :class_name,          exclusion:  { in: [nil] }
  validates :school_name,         exclusion:  { in: [nil] }
  validates :grade,               presence: true,
                                  numericality: { only_integer: true }
  validates :availabilities,      presence: true
  validates :instrument,          presence: true
  validates :comment,             exclusion:  { in: [nil] }

end
