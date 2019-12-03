# frozen_string_literal: true

require 'rails_helper'

# Monkeypatch: see https://github.com/rails/rails/issues/34790
if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe FormsController do
  describe 'GET index' do
    it 'should render the home page' do
      get :index
      expect(response).to redirect_to('/')
    end
  end
end
