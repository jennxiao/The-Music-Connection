require 'bcrypt'
module Login
  extend ActiveSupport::Concern
  
  included do
  
    # Verify that the database is not empty,
    # and fix it with default settings if it is.
    # Default settings must be changed by admin ASAP
    def verify_login
      if AdminSettings.first.nil?
        a = AdminSettings.new
        a.attributes = {
          form_open: false,
          salt: "salt",
          password_hash: BCrypt::Password.create("password"),
          last_updated: Time.at(1),
          email: "placeholder@tmc.com",
          session_id: "placeholder"
        }
        a.save
      end
    end
    
    # Check that admin is logged in, and
    # go to failpath if not
    def require_login(auth, failpath)
      settings = AdminSettings.last
      if settings.session_id != auth
        redirect_to failpath
      end
    end
    
    def attempt_login(password)
      settings = AdminSettings.last
      if settings.nil?
        return false
      end
      if BCrypt::Password.new(settings.password_hash) == password
        return settings.session_id
      end
      return ""
    end
  
  end

end