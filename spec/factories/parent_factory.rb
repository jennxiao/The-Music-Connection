# frozen_string_literal: true

FactoryBot.define do
  factory :parent do
    name { 'Parent Name' }
    phone { '321-654-0987' }
    email { 'parent@website.com' }
    address { 'Parent Address' }
    # rubocop:disable LineLength
    availabilities { 'Sunday&1970-01-01 13:00:00 -0800&1970-01-01 15:00:00 -0800;' }
    # rubocop:enable LineLength
    instrument { 'Piano,Violin' }
    experiences { '3-4 years' }
    comment { 'Parent comment' }
    number_of_matches { 0 }
    matched { false }
    grade { 9 }
    piano_home { true }
    past_app { true }
    lunch { true }
    matched_before { false }
  end
end
