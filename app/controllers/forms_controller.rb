class FormsController < ApplicationController
  def index
    redirect_to '/'
  end

  def teacher
    if !session[:form_opened]
      render text: "form closed!"
    end
  end

  def parent
      if !session[:form_opened]
          render text: "form closed!"
      end
  end

  def tutor
      if !session[:form_opened]
          render text: "form closed!"
      end
      session[:q_page] = 0
      @q_page = 0
  end

  def teacher_submit
    name = params[:question][:teacher_name]
    phone = params[:question][:phone]
    email = params[:question][:email]
    class_name = params[:question][:class_name]
    school_name = params[:question][:school_name]
    grade = params[:question][:grade]
    weekday = params[:question][:weekday]
    start_time = params[:question][:start_time]
    end_time = params[:question][:end_time]
    instrument = params[:question][:instrument]
    comment = params[:question][:comment]
    others = params[:question][:others]
    number_of_matches = 0
    times = ""
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
    for i in 0...weekday.count do
      availability = Availability.new
      availability.attributes = {weekday: weekday[i], start_time: start_time[i], end_time: end_time[i]}
      availability.save!
      times += (availability.id.to_s + "&")
    end
    times = times.chomp("&")
    teacher = Teacher.new
    teacher.attributes = {name: name, phone: phone,
      email: email, class_name: class_name, school_name: school_name,
      grade: grade, availabilities: times, instrument: instruments, comment: comment,
      number_of_matches: number_of_matches, matched: false}
    teacher.save!
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

    times = ""
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
    for i in 0...weekday.count do
      availability = Availability.new
      availability.attributes = {weekday: weekday[i], start_time: start_time[i], end_time: end_time[i]}
      availability.save!
      times += (availability.id.to_s + "&")
    end
    times = times.chomp("&")
    parent = Parent.new
    parent.attributes = {
      name: name, 
      phone: phone,
      email: email, 
      address: address, 
      grade: grade, 
      availabilities: times, 
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
    params[:question][:prev_again].strip.downcase == "yes" ? prev_again = true : prev_again = false
    preferred_student_class = params[:question][:preferred_student_class]
    comment = params[:question][:comment]
    others = params[:question][:others]
    number_of_matches = 0
    times = ""
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
    for i in 0...weekday.count do
      availability = Availability.new
      availability.attributes = {weekday: weekday[i], start_time: start_time[i], end_time: end_time[i]}
      availability.save!
      times += (availability.id.to_s + "&")
    end
    times = times.chomp("&")
    tutor = Tutor.new
    tutor.attributes = {name: name, phone: phone,
      email: email, sid: sid, year: year,
      major: major, minor: minor, experiences: experiences, availabilities: times,
    preferred_grade: preferred_grade, in_class: in_class, instrument: instruments,
    private: private, returning: returning,
    prev_again: prev_again, preferred_student_class: preferred_student_class, comment: comment,
    number_of_matches: number_of_matches, matched: false}
    tutor.save!

    render 'thank_you'
  end

end
