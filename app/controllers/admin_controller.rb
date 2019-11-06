require 'sysrandom'
class AdminController < ApplicationController
  include Login

  before_action :verify_login
  before_action except: [:home, :login] do
    require_login(session[:auth_token], '/admin')
  end

  def home
  end

  def login
    password = params[:password]
    session[:auth_token] = attempt_login(password)
    redirect_to '/admin/welcome'
  end

  def open_form
    change_settings({ new_form_open: true })
    flash[:notice] = 'Form is now opened!'
    redirect_to '/admin/welcome'
  end

  def close_form
    change_settings({ new_form_open: false })
    flash[:notice] = 'Form has been closed!'
    redirect_to '/admin/welcome'
  end

  def generate_matches
    @tutors = Tutor.where("tutors.comment != '' or tutors.preferred_student_class != ''")
    @teachers = Teacher.where.not(comment: [nil, ""])
    @parents = Parent.where.not(comment: [nil, ""])
    render 'generate_matches'
  end

  def run_algo
    Matcher.new.main
    flash[:notice] = 'Matching has been completed!'
    redirect_to '/admin/welcome'
  end

  def results
    @tt_pairs = Match.where("lower(tutee_id) LIKE 't%'")
    @tp_pairs = Match.where("lower(tutee_id) LIKE 'p%'")
  end

  def getRandomColor
    return "#" + (0..2).map{"%0x" % (rand * 0x80 + 0x80)}.join
  end

  def match_pair
    response = JSON.parse(request.body.read)
    Tutor.find(response['tutor_id'][1..-1]).matched = "true";
    client_type = response['client_id'][1..-1]
    if client_type == "p"
      Parent.find(response['client_id'][1..-1]).matched = "true";
    else
      Teacher.find(response['client_id'][1..-1]).matched = "true";
    end
    Match.create(:tutor_id => response['tutor_id'], :tutee_id => response['tutor_id'], :color => getRandomColor())
    puts "successfully matched!"
    render text: ""
  end

  def undo_pair
    response = JSON.parse(request.body.read)
    Tutor.find(response['tutor_id'][1..-1]).matched = "false";
    client_type = response['client_id'][1..-1]
    if client_type == "p"
      Parent.find(response['client_id'][1..-1]).matched = "false";
    else
      Teacher.find(response['client_id'][1..-1]).matched = "false";
    end
    result = Match.where(:tutor_id => response['tutor_id'], :tutee_id => response['tutor_id'])
    if result
      result.destroy_all
    end
    puts "successfully destroyed!"
    render text: ""
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
      salt: "this is never actually used bc library handles it for us",
      password_hash: BCrypt::Password.create(new_pass.nil? ? b.password_hash : new_pass),
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
