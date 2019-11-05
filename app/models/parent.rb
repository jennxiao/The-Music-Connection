class Parent < ActiveRecord::Base
  include ContactValidation
  
  validates :address,         presence: true
  validates :grade,           presence: true,
                              numericality: { only_integer: true }
  validates :availabilities,  presence: true
  validates :piano_home,      inclusion: { in: [true, false] }
  validates :instrument,      presence: true
  validates :experiences,     presence: true,
                              inclusion: { in: [ "< 6 months",
                                                 "6 months-1 year",
                                                 "1-2 years", 
                                                 "2-3 years", 
                                                 "3-4 years", 
                                                 "4+ years",  ]}
  validates :past_app,        inclusion: { in: [true, false] }
  validates :lunch,           inclusion: { in: [true, false] }
  validates :comment,         exclusion:  { in: [nil] }
end
