# frozen_string_literal: true

require 'rails_helper'

# Monkeypatch: see https://github.com/rails/rails/issues/34790
if RUBY_VERSION >= '2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # HACK: to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts 'Monkeypatch for ActionController::TestResponse no longer needed'
  end
end

# This makes rspec coverage happy
describe TutorsController do

end
