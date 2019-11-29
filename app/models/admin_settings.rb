# frozen_string_literal: true

class AdminSettings < ActiveRecord::Base
  validates :form_open,         inclusion: { in: [true, false] }
  validates :salt,              presence: true
  validates :password_hash,     presence: true
  validates :last_updated,      presence: true
  validates :email,             presence: true,
                                format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :session_id,        presence: true
end
