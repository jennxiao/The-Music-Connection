class WelcomeController < ApplicationController
  def index
    a = AdminSettings.last
    session[:form_open] = a.form_open
    puts "AAAAAAAAAAAAAAAAAAAAAA"
    puts a.form_open
  end
end
