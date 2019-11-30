# frozen_string_literal: true
require 'bcrypt'

# Module which handles admin user authentication
module Login
  extend ActiveSupport::Concern

  included do
    # Verify that the database is not empty,
    # and fix it with default settings if it is.
    # Default settings must be changed by admin ASAP
    # TODO: move this functionality to db:seed instead
    def verify_login
      if AdminSettings.first.nil?
        a = AdminSettings.new
        a.attributes = {
          form_open: false,
          salt: 'salt',
          password_hash: BCrypt::Password.create('password'),
          last_updated: Time.at(1),
          email: 'placeholder@tmc.com',
          session_id: 'placeholder'
        }
        a.save
      end
    end

    # Check that admin is logged in, and
    # go to failpath if not
    def require_login(auth, failpath)
      settings = AdminSettings.last
      redirect_to failpath if settings.session_id != auth
    end

    def attempt_login(password)
      settings = AdminSettings.last
      return false if settings.nil?
      if BCrypt::Password.new(settings.password_hash) == password
        return settings.session_id
      end

      ''
    end

    def default_password?
      a = AdminSettings.last
      BCrypt::Password.new(a.password_hash) == 'password'
    end

    def logged_in?(auth)
      a = AdminSettings.last
      a.session_id == auth
    end
  end
end
