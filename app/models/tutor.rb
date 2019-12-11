# frozen_string_literal: true

# Model representing a tutor
class Tutor < ActiveRecord::Base
  include ContactValidation
  extend FormHelper

  validates :sid,             presence: true,
                              numericality: { only_integer: true }
  validates :year,            presence: true,
                              inclusion: { in: ['Freshman',
                                                'Sophomore',
                                                'Junior',
                                                'Senior',
                                                'Other'] }
  validates :major,           exclusion:  { in: [nil] }
  validates :minor,           exclusion:  { in: [nil] }
  validates :experiences,     presence: true,
                              inclusion: { in: ['1-5 years',
                                                '5-10 years',
                                                '10+ years'] }
  validates :availabilities,  presence: true
  validates :preferred_grade, presence: true
#                              inclusion: { in: ['Grade 3-5',
#                                                'Grade 6-8',
#                                                'Grade 9-12'] }
  validates :in_class,        inclusion: { in: [true, false] }
  validates :private,         inclusion: { in: [true, false] }
  validates :instrument,      exclusion: { in: [nil] }
  validates :returning,       inclusion: { in: [true, false] }
  validates :prev_again,      inclusion: { in: [true, false] }
  validates :comment,         exclusion: { in: [nil] }

  # rubocop:disable MethodLength
  # rubocop:disable AbcSize
  def self.new_from_form(res)
    tutor = Tutor.new
    tutor.attributes = {
      name: res[:name],
      phone: res[:phone],
      email: res[:email],
      sid: res[:sid],
      year: res[:year],
      major: res[:major],
      minor: res[:minor],
      experiences: res[:exp],
      # rubocop:disable LineLength
      availabilities: serialize_availabilities(res[:weekday], res[:start_time], res[:end_time]),
      # rubocop:enable LineLength
      preferred_grade: serialize_array_output(res[:grade]),
      in_class: convert_to_boolean(res[:in_class]),
      private: convert_to_boolean(res[:private]),
      instrument: serialize_instruments(res[:instrument], res[:others]),
      returning: convert_to_boolean(res[:returning], 'returning'),
      prev_again: convert_to_boolean(res[:prev_again]),
      preferred_student_class: res[:preferred_student_class],
      comment: res[:comment],
      number_of_matches: 0,
      matched: false
    }
    tutor.save!
  end
  # rubocop:enable MethodLength
  # rubocop:enable AbcSize
end
