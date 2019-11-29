class FormsController < ApplicationController
  before_action :check_if_open, only: [:teacher, :parent, :tutor]

  def index
    redirect_to '/'
  end

  # Redirect to the appropriate form
  # (see config/routes.rb)
  def teacher
  end
  def parent
  end
  def tutor
  end

  def teacher_submit
    #only the first question object has these fields
    name = params[:question0][:teacher_name]
    phone = params[:question0][:phone]
    email = params[:question0][:email]

    p params
    for i in 0...params.count do 
      question_num = ("question" + i.to_s).to_sym
      if params[question_num] == nil
        next
      end
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
      instruments = ""
      other_count = 1
      for i in 0...instrument.count do
        if instrument[i] === "Others"
          instruments += (others[other_count] + "&")
          other_count += 1
        else
          instruments += (instrument[i] + "&")
        end
      end
      instruments = instruments.chomp("&")
      availabilities = ''
      for i in 0...weekday.count do 
        a = Availability.new(weekday[i], start_time[i], end_time[i])
        availabilities += Availability.serialize(a)
      end
      teacher = Teacher.new
      teacher.attributes = {name: name, phone: phone,
        email: email, class_name: class_name, school_name: school_name,
        grade: grade, availabilities: availabilities, instrument: instruments, comment: comment,
        number_of_matches: number_of_matches, matched: false}
      teacher.save!
    end
    render 'thank_you'
  end

  def parent_submit
    if Parent.new_from_form(params[:question])
      render 'thank_you' and return
    end
    redirect_to '/500' 
  end

  def tutor_submit
    if Tutor.new_from_form(params[:question])
      render 'thank_you' and return
    end
    redirect_to '/500'
  end

  private
  def check_if_open
    if !session[:form_open]
      redirect_to '/403'
    end
  end

end
