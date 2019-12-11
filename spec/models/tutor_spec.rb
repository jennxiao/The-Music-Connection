# frozen_string_literal: true

require 'rails_helper'
describe Tutor do
  it 'creates a new Tutor object and saves it into the database' do
    res = {
      name: 'Tutor Name',
      phone: '321-654-0987',
      email: 'tutor@website.com',
      sid: '3255354212',
      year: 'Freshman',
      major: 'Major Field of Study',
      minor: 'Minor field of Study',
      exp: '1-5 years',
      weekday: ['Sunday'],
      start_time: ['13:00:00'],
      end_time: ['15:00:00'],
      in_class: 'f',
      private: 't',
      instrument: ['Piano', 'Violin'],
      returning: 't',
      prev_again: 't',
      preferred_student_class: 'Preferred student or class',
      comment: 'Tutor comment',
      grade: ['9', '10']
    }

    expect(Tutor.new_from_form(res)).to eq(true)
  end
end
