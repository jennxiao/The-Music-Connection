# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    a = AdminSettings.last
    if a.nil?
      session[:form_open] = false
      return
    end
    session[:form_open] = a.form_open
  end
end
