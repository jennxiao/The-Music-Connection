class Tutor < ActiveRecord::Base
  include ContactValidation
  extend FormHelper

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
                              inclusion: { in: [ "Grade 3-5",
                                                 "Grade 6-8",
                                                 "Grade 9-12"  ]}
  validates :in_class,        inclusion: { in: [true, false] }
  validates :private,         inclusion: { in: [true, false] }
  validates :instrument,      exclusion:  { in: [nil] }
  validates :returning,       inclusion: { in: [true, false] }
  validates :prev_again,      inclusion: { in: [true, false] }
  validates :comment,         exclusion:  { in: [nil] }

  def self.new_from_form(r)
    tutor = Tutor.new
    tutor.attributes = {
      name: r[:name],
      phone: r[:phone],
      email: r[:email],
      sid: r[:sid],
      year: r[:year],
      major: r[:major],
      minor: r[:minor],
      experiences: r[:exp],
      availabilities: serialize_availabilities(r[:weekday], r[:start_time], r[:end_time]), 
      preferred_grade: r[:preferred_grade],
      in_class: convert_to_boolean(r[:in_class]),
      private: convert_to_boolean(r[:private]),
      instrument: serialize_instruments(r[:instrument], r[:others]),
      returning: convert_to_boolean(r[:returning], "returning"),
      prev_again: convert_to_boolean(r[:prev_again]),
      preferred_student_class: r[:preferred_student_class],
      comment: r[:comment],
      number_of_matches: 0,
      matched: false
    }
    return tutor.save
  end
end
