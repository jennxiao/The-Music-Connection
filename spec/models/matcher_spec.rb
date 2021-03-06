# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Matcher, type: :model do
  it 'empty matcher result' do
    expect(Matcher.calculate).to eq([])
  end
  it 'non-empty matcher result' do
    Rails.application.load_seed
    Parent.create(name: 'Anthony Zhou Parent',
                  phone: '123-456-7433',
                  email: 'anthonyfzhouParent@berkeley.edu',
                  address: '2110 Haste St, Apt 403',
                  availabilities: 'Monday,13:00:00,15:00:00',
                  instrument: 'Piano',
                  experiences: '< 6 months',
                  comment: '',
                  number_of_matches: 0,
                  matched: false,
                  created_at: '2019-12-10 18:39:47',
                  updated_at: '2019-12-10 18:39:47',
                  grade: 6,
                  piano_home: false,
                  past_app: false,
                  lunch: false,
                  matched_before: true)
    Tutor.create(name: 'Anthony Zhou Tutor1',
                 phone: '123-456-7433',
                 email: 'anthonyfzhouTutor@berkeley.edu',
                 year: 'Sophomore',
                 major: 'Computer Science',
                 minor: '',
                 experiences: '1-5 years',
                 availabilities: 'Monday,13:00:00,15:00:00',
                 preferred_grade: 'Grade 6-8',
                 instrument: 'Piano',
                 preferred_student_class: '',
                 comment: '',
                 number_of_matches: 0,
                 matched: false,
                 created_at: '2019-12-10 18:39:47',
                 updated_at: '2019-12-10 18:39:47',
                 sid: 3032748539,
                 in_class: true,
                 private: false,
                 returning: true,
                 prev_again: true)
    Tutor.create(name: 'Anthony Zhou Tutor2',
                 phone: '123-456-7433',
                 email: 'anthonyfzhouTutor@berkeley.edu',
                 year: 'Sophomore',
                 major: 'Computer Science',
                 minor: '',
                 experiences: '1-5 years',
                 availabilities: 'Monday,13:00:00,15:00:00',
                 preferred_grade: 'Grade 6-8',
                 instrument: 'Piano',
                 preferred_student_class: '',
                 comment: '',
                 number_of_matches: 0,
                 matched: false,
                 created_at: '2019-12-10 18:39:47',
                 updated_at: '2019-12-10 18:39:47',
                 sid: 3032748539,
                 in_class: true,
                 private: false,
                 returning: true,
                 prev_again: true)
    Tutor.create(name: 'Anthony Zhou Tutor3',
                 phone: '123-456-7433',
                 email: 'anthonyfzhouTutor@berkeley.edu',
                 year: 'Sophomore',
                 major: 'Computer Science',
                 minor: '',
                 experiences: '1-5 years',
                 availabilities: 'Monday,13:00:00,15:00:00',
                 preferred_grade: 'Grade 6-8',
                 instrument: 'Piano',
                 preferred_student_class: '',
                 comment: '',
                 number_of_matches: 0,
                 matched: false,
                 created_at: '2019-12-10 18:39:47',
                 updated_at: '2019-12-10 18:39:47',
                 sid: 3032748539,
                 in_class: true,
                 private: false,
                 returning: true,
                 prev_again: true)
    Teacher.create(name: 'Anthony Zhou Teacher',
                   phone: '123-456-7433',
                   email: 'anthonyfzhouTeacher@berkeley.edu',
                   class_name: 'Default Class',
                   school_name: 'Default School',
                   availabilities: 'Monday,13:00:00,15:00:00',
                   instrument: 'Piano',
                   comment: '',
                   number_of_matches: 0,
                   matched: false,
                   created_at: '2019-12-10 18:39:47',
                   updated_at: '2019-12-10 18:39:47',
                   grade: 6,
                   matched_before: false)
    Match.create(tutors_id: 1,
                 teachers_id: 1,
                 parents_id: nil,
                 forced: false,
                 score: 34)
    Matcher.calculate
  end
end
