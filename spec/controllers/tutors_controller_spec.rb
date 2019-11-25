require 'rails_helper'
describe TutorsController do
  describe 'GET index' do
    let!(:tutor) {FactoryGirl.create(:tutor)}

    it 'should assign instance variable for tutors' do
      get :index
      expect(tutor.name).to eql(Tutor.first.name)
      expect(tutor.phone).to eql(Tutor.first.phone)
      expect(tutor.email).to eql(Tutor.first.email)
      expect(tutor.sid).to eql(Tutor.first.sid)
      expect(tutor.year).to eql(Tutor.first.year)
      expect(tutor.major).to eql(Tutor.first.major)
      expect(tutor.minor).to eql(Tutor.first.minor)
      expect(tutor.experiences).to eql(Tutor.first.experiences)
      expect(tutor.preferred_grade).to eql(Tutor.first.preferred_grade)
      expect(tutor.in_class).to eql(Tutor.first.in_class)
      expect(tutor.availabilities).to eql(Tutor.first.availabilities)
     # expect(tutor.availabilities.weekday).to eql(Tutor.first.availabilities.weekday)
     # expect(tutor.availabilities.start_time).to eql(Tutor.first.availabilities.start_time)
     # expect(tutor.availabilities.end_time).to eql(Tutor.first.availabilities.end_time)
      expect(tutor.instrument).to eql(Tutor.first.instrument)
      expect(tutor.private).to eql(Tutor.first.private)
      expect(tutor.returning).to eql(Tutor.first.returning)
      expect(tutor.prev_again).to eql(Tutor.first.prev_again)
      expect(tutor.preferred_student_class).to eql(Tutor.first.preferred_student_class)
      expect(tutor.comment).to eql(Tutor.first.comment)
      expect(tutor.number_of_matches).to eql(Tutor.first.number_of_matches)
      expect(tutor.matched).to eql(Tutor.first.matched)
    end
  end
end
