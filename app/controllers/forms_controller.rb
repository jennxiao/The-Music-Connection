class FormsController < ApplicationController
  def index
    redirect_to '/'
  end

  def teacher
    if !session[:form_open]
      render text: "form closed!"
    end
  end

  def parent
    if !session[:form_open]
      render text: "form closed!"
    end
  end

  def tutor
    if !session[:form_open]
      render text: "form closed!"
    end
    session[:q_page] = 0
    @q_page = 0
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
    name = params[:question][:name]
    phone = params[:question][:phone]
    email = params[:question][:email]
    address = params[:question][:address]
    grade = params[:question][:grade]
    weekday = params[:question][:weekday]
    start_time = params[:question][:start_time]
    end_time = params[:question][:end_time]
    params[:question][:piano_home].strip.downcase == "yes" ? piano_home = true : piano_home = false
    instrument = params[:question][:instrument]
    experiences = params[:question][:experiences].strip
    params[:question][:pastapp].strip.downcase == "yes" ? pastapp = true : pastapp = false
    params[:question][:lunch].strip.downcase == "yes" ? lunch = true : lunch = false
    comment = params[:question][:comment]
    others = params[:question][:others]
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
    parent = Parent.new
    parent.attributes = {
      name: name, 
      phone: phone,
      email: email, 
      address: address, 
      grade: grade, 
      availabilities: availabilities, 
      piano_home: piano_home,
      instrument: instruments, 
      experiences: experiences,
      past_app: pastapp, 
      lunch: lunch, 
      comment: comment, 
      number_of_matches: number_of_matches, 
      matched: false
    }
    parent.save!
    render 'thank_you'
  end

  def tutor_submit
    name = params[:question][:name]
    phone = params[:question][:phone]
    email = params[:question][:email]
    sid = params[:question][:sid]
    year = params[:question][:year]
    major = params[:question][:major]
    minor = params[:question][:minor]
    experiences = params[:question][:exp]
    weekday = params[:question][:weekday]
    start_time = params[:question][:start_time]
    end_time = params[:question][:end_time]
    preferred_grade = params[:question][:preferred_grade]
    params[:question][:in_class].strip.downcase == "yes" ? in_class = true : in_class = false
    params[:question][:private].strip.downcase == "yes" ? private = true : private = false
    instrument = params[:question][:instrument]
    params[:question][:returning].strip.downcase == "returning" ? returning = true : returning = false
    if params[:question][:prev_again].nil? || params[:question][:prev_again].strip.downcase == "yes"
      prev_again = true 
    else
      prev_again = false
    end
    preferred_student_class = params[:question][:preferred_student_class]
    comment = params[:question][:comment]
    others = params[:question][:others]
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
    tutor = Tutor.new
    tutor.attributes = {name: name, phone: phone,
      email: email, sid: sid, year: year,
      major: major, minor: minor, experiences: experiences, availabilities: availabilities,
    preferred_grade: preferred_grade, in_class: in_class, instrument: instruments,
    private: private, returning: returning,
    prev_again: prev_again, preferred_student_class: preferred_student_class, comment: comment,
    number_of_matches: number_of_matches, matched: false}
    tutor.save!

    render 'thank_you'
  end

end
