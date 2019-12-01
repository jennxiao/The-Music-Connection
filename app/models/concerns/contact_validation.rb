# frozen_string_literal: true

# Shared validations for all clients
module ContactValidation
  extend ActiveSupport::Concern

  included do
    validates :name,      presence: true,
                          length: { minimum: 1 }
    validates :phone,     presence: true,
                          format: { with: /[0-9]{3}-[0-9]{3}-[0-9]{4}/,
                                    message: 'Invalid phone number format' }
    validates :email,     presence: true,
                          format: { with: URI::MailTo::EMAIL_REGEXP }
  end
end
