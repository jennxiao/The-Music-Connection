# frozen_string_literal: true

class Parent < ActiveRecord::Base
  include ContactValidation
  extend FormHelper

  validates :address,         presence: true
  validates :grade,           presence: true,
                              numericality: { only_integer: true }
  validates :availabilities,  presence: true
  validates :piano_home,      inclusion: { in: [true, false] }
  validates :instrument,      presence: true
  validates :experiences,     presence: true,
                              inclusion: { in: ['< 6 months',
                                                '6 months-1 year',
                                                '1-2 years',
                                                '2-3 years',
                                                '3-4 years',
                                                '4+ years'] }
  validates :past_app,        inclusion: { in: [true, false] }
  validates :lunch,           inclusion: { in: [true, false] }
  validates :comment,         exclusion: { in: [nil] }
  validates :matched_before,  inclusion: { in: [true, false] }

  # The fields number_of_matches, matched are unused

  def self.new_from_form(res)
    parent = Parent.new
    parent.attributes = {
      name: res[:name],
      phone: res[:phone],
      email: res[:email],
      address: res[:address],
      grade: res[:grade],
      availabilities: serialize_availabilities(res[:weekday], res[:start_time], res[:end_time]),
      piano_home: convert_to_boolean(res[:piano_home]),
      instrument: serialize_instruments(res[:instrument], res[:others]),
      experiences: res[:experiences],
      past_app: convert_to_boolean(res[:pastapp]),
      lunch: convert_to_boolean(res[:lunch]),
      comment: res[:comment],
      number_of_matches: 0,
      matched: false,
      matched_before: false
    }
    parent.save
  end
end
