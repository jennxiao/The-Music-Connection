# frozen_string_literal: true

# in spec/spec_helper.rb
require 'axe/rspec'
require 'rails_helper'

RSpec.feature 'Home page accessibility', type: :feature do
  scenario 'Home page accessibility', js: true do
    visit '/'
    expect(page).to be_accessible
  end
end
