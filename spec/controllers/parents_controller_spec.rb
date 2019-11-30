# frozen_string_literal: true

require 'rails_helper'
describe ParentsController do
  describe 'GET index' do
    let!(:parent) { FactoryGirl.create(:parent) }

    it 'should assign instance variable for parents' do
      get :index
      expect(parent.name).to eql(Parent.first.name)
      expect(parent.phone).to eql(Parent.first.phone)
      expect(parent.email).to eql(Parent.first.email)
      expect(parent.address).to eql(Parent.first.address)
      expect(parent.piano_home).to eql(Parent.first.piano_home)
      expect(parent.grade).to eql(Parent.first.grade)
      expect(parent.availabilities).to eql(Parent.first.availabilities)
      expect(parent.instrument).to eql(Parent.first.instrument)
      expect(parent.experiences).to eql(Parent.first.experiences)
      expect(parent.past_app).to eql(Parent.first.past_app)
      expect(parent.lunch).to eql(Parent.first.lunch)
      expect(parent.comment).to eql(Parent.first.comment)
      expect(parent.number_of_matches).to eql(Parent.first.number_of_matches)
      expect(parent.matched).to eql(Parent.first.matched)
    end
  end
end
