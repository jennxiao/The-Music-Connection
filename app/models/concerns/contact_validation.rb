# frozen_string_literal: true

module ContactValidation
  extend ActiveSupport::Concern

  included do
    validates :name,      presence: true,
                          length: { minimum: 1 }
    validates :phone,     presence: true,
                          format: { with: /[0-9]{3}-[0-9]{3}-[0-9]{4}/,
                                    message: 'Phone number must be in xxx-xxx-xxxx format.' }
    validates :email,     presence: true,
                          format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end
