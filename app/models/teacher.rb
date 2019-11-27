class Teacher < ActiveRecord::Base
  include ContactValidation
  
  validates :class_name,          exclusion:  { in: [nil] }
  validates :school_name,         exclusion:  { in: [nil] }
  validates :grade,               presence: true,
                                  numericality: { only_integer: true }
  validates :availabilities,      presence: true
  validates :instrument,          presence: true
  #validates :comment,             exclusion:  { in: [nil] }
  #has_many :classes

#  accepts_nested_attributes_for :classes, :reject_if => :all_blank, :allow_destroy => true

  #accepts_nested_attributes_for :classes, :reject_if => :all_blank, :allow_destroy => true


end
