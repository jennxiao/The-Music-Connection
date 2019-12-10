# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#Default Single Availability: Monday&13:00:00&15:00:00
#Default created/updated: created_at: "2019-12-10 18:39:47", updated_at: "2019-12-10 18:39:47

AdminSettings.create({
    form_open: false,
    salt: 'salt',
    password_hash: BCrypt::Password.create('password'),
    last_updated: Time.at(1),
    email: 'placeholder@tmc.com',
    session_id: 'placeholder'
})

case Rails.env
when "development"
  default_teacher = Teacher.create({:name => "Anthony Zhou Teacher",
                    :phone => "123-456-7433",
                    :email => "anthonyfzhouTeacher@berkeley.edu",
                    :class_name => "Default Class",
                    :school_name => "Default School",
                    :availabilities => "Monday&13:00:00&15:00:00",
                    :instrument => "Piano",
                    :comment => "",
                    :number_of_matches => 0,
                    :matched => false,
                    :created_at => "2019-12-10 18:39:47",
                    :updated_at => "2019-12-10 18:39:47",
                    :grade => 6,
                    :matched_before => false })

  default_tutor = Tutor.create({:name => "Anthony Zhou Tutor",
                  :phone => "123-456-7433",
                  :email => "anthonyfzhouTutor@berkeley.edu",
                  :year => "Sophomore",
                  :major => "Computer Science",
                  :minor => "",
                  :experiences => "1-5 years",
                  :availabilities => "Monday&13:00:00&15:00:00",
                  :preferred_grade => "Grade 6-8",
                  :instrument => "Piano",
                  :preferred_student_class => "",
                  :comment => "",
                  :number_of_matches => 0,
                  :matched => false,
                  :created_at => "2019-12-10 18:39:47",
                  :updated_at => "2019-12-10 18:39:47",
                  :sid => 3032748539,
                  :in_class => true,
                  :private => false,
                  :returning => true,
                  :prev_again => true})

  default_parent = Parent.create({:name => "Anthony Zhou Parent",
                    :phone => "123-456-7433",
                    :email => "anthonyfzhouParent@berkeley.edu",
                    :address => "2110 Haste St, Apt 403",
                    :availabilities => "Monday&13:00:00&15:00:00",
                  :instrument => "Piano",
                    :experiences => "< 6 months",
                    :comment => "",
                    :number_of_matches => 0,
                    :matched => false,
                    :created_at => "2019-12-10 18:39:47",
                    :updated_at => "2019-12-10 18:39:47",
                    :grade => 6,
                    :piano_home => false,
                    :past_app => false,
                    :lunch => false,
                    :matched_before => false})
when "production"
  # Do nothing for now
end


