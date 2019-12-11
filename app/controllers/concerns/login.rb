# frozen_string_literal: true

require 'bcrypt'

# Module which handles admin user authentication
module Login
  extend ActiveSupport::Concern

  included do
    # Verify that the database is not empty.
    # If it is empty, then db:seed was not run.
    def verify_login
      if AdminSettings.first.nil?
        redirect_to '/500'
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
