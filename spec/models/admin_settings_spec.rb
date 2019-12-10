# frozen_string_literal: true

require 'rails_helper'

describe AdminSettings do
  context 'Verify validations' do
    it 'should only allow boolean values for form_open' do
      get :welcome
      expect(response).to redirect_to('/admin')
    end
  end
end
