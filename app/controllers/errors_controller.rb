# frozen_string_literal: true

class ErrorsController < ApplicationController
  def permission_denied
    render :file => 'public/403.html', status: 403
  end

  def not_found
    render :file => 'public/404.html', status: 404
  end

  def unacceptable
    render :file => 'public/422.html', status: 422
  end

  def internal_error
    render :file => 'public/500.html', status: 500
  end
end
