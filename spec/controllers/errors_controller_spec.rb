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

describe ErrorsController do
  describe '#permission_denied' do
    it 'should render permission denied' do
      get :permission_denied
      expect(response).to have_http_status(403)
    end
  end
  describe '#not_found' do
    it 'should render not found' do
      get :not_found
      expect(response).to have_http_status(404)
    end
  end
  describe '#unacceptable' do
    it 'should render unacceptable' do
      get :unacceptable
      expect(response).to have_http_status(422)
    end
  end
  describe '#internal_error' do
    it 'should render internal error' do
      get :internal_error
      expect(response).to have_http_status(500)
    end
  end
end
