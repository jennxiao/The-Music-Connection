class AdminSettings < ActiveRecord::Base
  validates :form_open,         presence: true
  validates :salt,              presence: true
  validates :password_hash,     presence: true
  validates :last_updated,      presence: true
  validates :email,             presence: true,
                                format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :session_id,        presence: true
                                
end
