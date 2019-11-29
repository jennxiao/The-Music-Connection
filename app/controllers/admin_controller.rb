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
    redirect_to '/admin/welcome'
  end

  def close_form
    change_settings(new_form_open: false)
    flash[:notice] = 'Form closed'
    redirect_to '/admin/welcome'
  end

  def generate_matches
    m = Matcher.calculate
    # m = Match.all
    @calculated = []
    m.each do |match|
      entry = {
        tutor: match.tutor.id,
        tutor_name: match.tutor.name,
        score: match.score,
        teacher: 'nil',
        teacher_name: 'nil',
        parent: 'nil',
        parent_name: 'nil'
      }
      if !match.teacher.nil?
        entry[:teacher] = match.teacher.id
        entry[:teacher_name] = match.teacher.name
      else
        entry[:parent] = match.parent.id
        entry[:parent_name] = match.parent.name
      end
      @calculated.push(entry)
    end
    render 'generate_matches'
  end

  def match_pair
    response = JSON.parse(request.body.read)
    Tutor.find(response['tutor_id'][1..-1]).matched = 'true'
    client_type = response['client_id'][1..-1]
    if client_type == 'p'
      Parent.find(response['client_id'][1..-1]).matched = 'true'
    else
      Teacher.find(response['client_id'][1..-1]).matched = 'true'
    end
    Match.create(tutor_id: response['tutor_id'], tutee_id: response['tutor_id'], color: getRandomColor)
    puts 'successfully matched!'
    render text: ''
  end

  def undo_pair
    response = JSON.parse(request.body.read)
    Tutor.find(response['tutor_id'][1..-1]).matched = 'false'
    client_type = response['client_id'][1..-1]
    if client_type == 'p'
      Parent.find(response['client_id'][1..-1]).matched = 'false'
    else
      Teacher.find(response['client_id'][1..-1]).matched = 'false'
    end
    result = Match.where(tutor_id: response['tutor_id'], tutee_id: response['tutor_id'])
    result&.destroy_all
    puts 'successfully destroyed!'
    render text: ''
  end

  def reset_database
    Teacher.delete_all
    Tutor.delete_all
    Parent.delete_all
    Match.delete_all
    flash[:notice] = 'Database has been reset!'
    redirect_to '/admin/welcome'
  end

  def reset_matching
    Teacher.all.each do |t|
      t['matched'] = false
    end
    Tutor.all.each do |t|
      t['matched'] = false
    end
    Parent.all.each do |p|
      p['matched'] = false
    end
    Match.delete_all
    flash[:notice] = 'Matching has been reset!'
    redirect_to '/admin/welcome'
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
