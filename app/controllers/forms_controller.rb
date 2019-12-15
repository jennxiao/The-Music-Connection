# frozen_string_literal: true

class FormsController < ApplicationController
  before_action :check_if_open, only: %i[teacher parent tutor]
  @@tutorText = 'Thanks for Applying!'
  @@tutorLink = 'google.com'
  
  def self.set_tutor_text(text)
	  @@tutorText = text
  end
  
  def self.set_tutor_link(link)
	  @@tutorLink = link
  end

  def index
    redirect_to '/'
  end

  # Redirect to the appropriate form
  # (see config/routes.rb)
  def teacher; end

  def parent; end

  def tutor
	  @tutorLink = @@tutorLink
	  @tutorText = @@tutorText
  end

  def teacher_submit
    # only the first question object has these fields
    name = params[:question][:teacher_name]
    phone = params[:question][:phone]
    email = params[:question][:email]

    #  NEED A CHECK IN INSTRUMENTS FIELD OF HASH BECAUSE THE "OTHER INSTRUMENT FIELD SENDS A BLANK STRING IF NO INSTRUMENT IS TYPED IN"

    p params
    (0...params.count).each do |i|
      question_num = ('question' + i.to_s).to_sym
      next if params[question_num].nil?

      class_name = params[question_num][:class_name]
      school_name = params[question_num][:school_name]
      grade = params[question_num][:grade]
      weekday = params[question_num][:weekday]
      start_time = params[question_num][:start_time]
      end_time = params[question_num][:end_time]
      instrument = params[question_num][:instrument]
      comment = params[question_num][:comment]
      others = params[question_num][:others]
      number_of_matches = 0
      instruments = ''
      other_count = 1
      (0...instrument.count).each do |i|
        if instrument[i] === 'Others'
          instruments += (others[other_count] + ',')
          other_count += 1
        else
          instruments += (instrument[i] + ',')
        end
      end
      instruments = instruments.chomp(',')
      availabilities = ''
      (0...weekday.count).each do |i|
        a = Availability.new(weekday[i], start_time[i], end_time[i])
        availabilities += Availability.serialize(a)
      end
      grades = ''
      (0...grade.count).each do |i|
        grades += (grade[i].to_s + ',')
      end
	  grades.chomp!(',')
      teacher = Teacher.new
      teacher.attributes = { name: name, phone: phone,
                             email: email, class_name: class_name, school_name: school_name,
                             grade: grades, availabilities: availabilities, instrument: instruments, comment: comment,
                             number_of_matches: number_of_matches, matched: false }
      teacher.save!
    end
    render 'thank_you'
  end

  def parent_submit
    render('thank_you') && return if Parent.new_from_form(params[:question])
    redirect_to '/500'
  end

  def tutor_submit
    render('thank_you') && return if Tutor.new_from_form(params[:question])
    redirect_to '/500'
  end

  private

  def check_if_open
    redirect_to '/403' unless session[:form_open]
  end
end
