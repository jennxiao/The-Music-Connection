# frozen_string_literal: true

require 'rails_helper'
describe Parent do
  it 'creates a new Parent object and saves it into the database' do
    res = {
      name: 'Parent Name',
      phone: '321-654-0987',
      email: 'parent@website.com',
      address: 'Parent Address',
      weekday: ['Sunday'],
      start_time: ['13:00:00'],
      end_time: ['15:00:00'],
      instrument: ['Piano', 'Violin'],
      experiences: '3-4 years',
      comment: 'Parent comment',
      matched_in_past_semester: 't',
      grade: '9',
      piano_home: 't',
      pastapp: 't',
      lunch: 't'
    }

    expect(Parent.new_from_form(res)).to eq(true)
  end
end
