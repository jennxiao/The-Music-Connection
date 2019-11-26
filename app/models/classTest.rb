class Class < ActiveRecord::Base
    include ContactValidation
    
    validates :class_name,          exclusion:  { in: [nil] }
    validates :school_name,         exclusion:  { in: [nil] }
    validates :grade,               presence: true,
                                    numericality: { only_integer: true }
    validates :class_time,      presence: true
    validates :instrument,          presence: true
    validates :instrument,             exclusion:  { in: [nil] }
  
  end
  