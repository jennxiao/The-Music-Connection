class Tutor < ActiveRecord::Base
  include ContactValidation
  validates :sid,             presence: true,
                              numericality: { only_integer: true }
  validates :year,            presence: true,
                              inclusion: { in: [ "Freshman",
                                                 "Sophomore",
                                                 "Junior",
                                                 "Senior",
                                                 "Other"      ]}
  validates :major,           exclusion:  { in: [nil] }
  validates :minor,           exclusion:  { in: [nil] }
  validates :experiences,     presence: true,
                              inclusion: { in: [ "1-5 years",
                                                 "5-10 years",
                                                 "10+ years"   ]}
  validates :availabilities,  presence: true
  validates :preferred_grade, presence: true,
                              inclusion: { in: [ "Grade 3~5",
                                                 "Grade 6~8",
                                                 "Grade 9~12"  ]}
  validates :in_class,        inclusion: { in: [true, false] }
  validates :private,         inclusion: { in: [true, false] }
  validates :instrument,      exclusion:  { in: [nil] }
  validates :returning,       inclusion: { in: [true, false] }
  validates :prev_again,      inclusion: { in: [true, false] }
  validates :comment,         exclusion:  { in: [nil] }

end
