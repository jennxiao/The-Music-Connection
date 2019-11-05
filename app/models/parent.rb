class Parent < ActiveRecord::Base
  include ContactValidation
  
  validates :address,         presence: true
  validates :grade,           presence: true,
                              numericality: { only_integer: true }
  validates :availabilities,  presence: true
  validates :piano_home,      inclusion: { in: ["t", "f"] }
  validates :instrument,      presence: true
  validates :experiences,     presence: true,
                              inclusion: { in: [ "< 6 months",
                                                 "6 months-1 year",
                                                 "1-2 years", 
                                                 "2-3 years", 
                                                 "3-4 years", 
                                                 "4+ years",  ]}
  validates :pastapp,         inclusion: { in: ["t", "f"] }
  validates :lunch,           inclusion: { in: ["t", "f"] }
  validates :comment,         exclusion:  { in: [nil] }
end
