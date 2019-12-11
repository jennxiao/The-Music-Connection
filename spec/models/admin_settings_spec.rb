# frozen_string_literal: true

require 'rails_helper'

describe AdminSettings do
  let(:setting) do
    AdminSettings.new(
      form_open: false,
      salt: 'salt',
      password_hash: BCrypt::Password.create('password'),
      last_updated: Time.at(1),
      email: 'placeholder@tmc.com',
      session_id: 'placeholder'
    )
  end
  context 'Verify validations' do
    it 'successfully validates a valid AdminSettings' do
      expect(setting.valid?).to be true
    end
    it 'fails missing password_hash' do
      expect(setting.update_attributes(password_hash: nil)).to be false
    end
    it 'fails missing last_updated' do
      expect(setting.update_attributes(last_updated: nil)).to be false
    end
    it 'fails invalid email' do
      expect(setting.update_attributes(email: 'arbitrary string')).to be false
    end
    it 'fails missing session_id' do
      expect(setting.update_attributes(session_id: nil)).to be false
    end
  end
end
