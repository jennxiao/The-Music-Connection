# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Default Single Availability: Monday&13:00:00&15:00:00
#Default created/updated: created_at: "2019-12-10 18:39:47", updated_at: "2019-12-10 18:39:47

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
							  :preferred_grade => "Grade 3-5",
							  :instrument => "Piano",
							  :preferred_student_class => "",
							  :comment => "",
							  :number_of_matches => 0,
							  :matched => false,
							  :created_at => "2019-12-10 18:39:47",
							  :updated_at => "2019-12-10 18:39:47",
							  :sid => 3032748539,
							  :in_class => false,
							  :private => false,
							  :returning => true,
							  :prev_again => true})

#create_table "parents", force: :cascade do |t|
#  t.string   "name"
#  t.string   "phone"
#  t.string   "email"
#  t.string   "address"
#  t.string   "availabilities"
#  t.string   "instrument"
#  t.string   "experiences"
#  t.string   "comment"
#  t.integer  "number_of_matches"
#  t.boolean  "matched"
#  t.datetime "created_at",        null: false
#  t.datetime "updated_at",        null: false
#  t.integer  "grade"
#  t.boolean  "piano_home"
#  t.boolean  "past_app"
#  t.boolean  "lunch"
#  t.boolean  "matched_before"
#end

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
