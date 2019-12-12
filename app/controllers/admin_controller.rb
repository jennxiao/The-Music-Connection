# frozen_string_literal: true

require 'sysrandom'
class AdminController < ApplicationController
  include Login

  before_action :verify_login
  before_action except: %i[home login] do
    require_login(session[:auth_token], '/admin')
  end

  def home
    redirect_to '/admin/welcome' if logged_in?(session[:auth_token])
  end

  def login
    password = params[:password]
    session[:auth_token] = attempt_login(password)
    redirect_to '/admin/welcome'
  end

  def logout
    session[:auth_token] = ''
    redirect_to '/admin'
  end

  def welcome
    flash[:password] = if default_password?
                         'Password is at default value: please update ASAP!'
                       else
                         ''
                       end
  end

  def update_settings_post
    if session[:auth_token] != attempt_login(params[:old_password])
      flash[:notice] = 'Incorrect password'
      redirect_to('/admin/update_settings') && return
    end
    change_settings(
      new_pass: params[:new_password].empty? ? nil : params[:new_password],
      new_email: params[:new_email].empty? ? nil : params[:new_email]
    )
    flash[:notice] = 'Updated settings'
    redirect_to('/admin/welcome') && return
  end

  def open_form
    change_settings(new_form_open: true)
    flash[:notice] = 'Form opened'
    redirect_to('/admin/welcome') && return
  end

  def close_form
    change_settings(new_form_open: false)
    flash[:notice] = 'Form closed'
    redirect_to('/admin/welcome') && return
  end

  def generate_matches
    m = Matcher.calculate
    # m = Match.all
	puts(m)
    @calculated = []
    m.each do |match|
	  if !match.teacher.nil?
		match_identity = match.teacher
		identity = 'Teacher'
		location = match_identity.school_name
	  else
		match_identity = match.parent
		identity = 'Parent'
		location = match_identity.address
	  end
      entry = {
        tutor_name: match.tutor.name,
		tutor_number: match.tutor.phone,
		tutor_email: match.tutor.email,
		tutor_instruments: match.tutor.instrument,
		tutor_experience: match.tutor.experiences,
		tutor_availabilities: match.tutor.availabilities,
		match_identity: identity,
		score: match.score,
		match_name: match_identity.name,
		match_phone: match_identity.phone,
		match_email: match_identity.email,
		match_instruments: match_identity.instrument,
		match_availabilities: match_identity.availabilities,
		match_location: location
      }
      @calculated.push(entry)
    end
    render 'display_matches'
  end


  def reset_database; end

  def confirm_reset_database
    confirmation = params[:reset_confirmation]
    if confirmation == 'Yes'
      Teacher.delete_all
      Tutor.delete_all
      Parent.delete_all
      Match.delete_all
      flash[:notice] = 'Database reset'
    else
      flash[:notice] = 'Database NOT reset'
    end
    redirect_to('/admin/welcome') && return
  end

  def match_pair
    # TODO: implement this
  end

  def undo_pair
    # TODO: implement this
  end

  def reset_matching
    # TODO: implement this
  end

  private

  def change_settings(c)
    new_form_open = c[:new_form_open]
    new_pass = c[:new_pass]
    new_email = c[:new_email]
    b = AdminSettings.last
    a = AdminSettings.new
    a.attributes = {
      form_open: new_form_open.nil? ? b.form_open : new_form_open,
      salt: 'this is never actually used bc library handles it for us',
      password_hash: new_pass.nil? ? b.password_hash : BCrypt::Password.create(new_pass),
      last_updated: Time.now,
      email: new_email.nil? ? b.email : new_email,
      session_id: Sysrandom.hex(64)
    }
    if a.valid?
      a.save
      session[:auth_token] = a.session_id
    end
  end
end
