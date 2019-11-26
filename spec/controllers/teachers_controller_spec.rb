require 'rails_helper'
describe TeachersController do
  describe 'GET index' do
    let!(:teacher) {FactoryGirl.create(:teacher)}

    it 'should assign instance variable for teachers' do
      get :index
      expect(teacher.name).to eql(Teacher.first.name)
      expect(teacher.phone).to eql(Teacher.first.phone)
      expect(teacher.email).to eql(Teacher.first.email)
      expect(teacher.class_name).to eql(Teacher.first.class_name)
      expect(teacher.school_name).to eql(Teacher.first.school_name)
      expect(teacher.grade).to eql(Teacher.first.grade)
      expect(teacher.availabilities).to eql(Teacher.first.availabilities)
     # expect(teacher.availabilities.weekday).to eql(Teacher.first.availabilities.weekday)
     # expect(teacher.availabilities.start_time).to eql(Teacher.first.availabilities.start_time)
     # expect(teacher.availabilities.end_time).to eql(Teacher.first.availabilities.end_time)
      expect(teacher.instrument).to eql(Teacher.first.instrument)
      expect(teacher.comment).to eql(Teacher.first.comment)
      expect(teacher.number_of_matches).to eql(Teacher.first.number_of_matches)
      expect(teacher.matched).to eql(Teacher.first.matched)
    end
  end
end
