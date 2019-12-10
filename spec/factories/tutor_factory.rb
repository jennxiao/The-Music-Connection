# frozen_string_literal: true

FactoryBot.define do
  factory :tutor do
    name { 'Tutor Name' }
    phone { '123-456-7890' }
    email { 'tutor@website.com' }
    year { 'Freshman' }
    major { 'Major field of study' }
    minor { 'Minor field of study' }
    experiences { '1-5 years' }
    availabilities { 'Sunday&13:00:00&15:00:00;' }
    preferred_grade { 'Grade 9-12' }
    instrument { 'Violin' }
    preferred_student_class { 'Preferred student or class' }
    comment { 'Tutor comment' }
    number_of_matches { 0 }
    matched { false }
    sid { 3255354212 }
    in_class { false }

    private { true }

    returning { true }
    prev_again { true }
  end
end
