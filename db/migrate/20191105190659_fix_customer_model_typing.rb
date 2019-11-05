class FixCustomerModelTyping < ActiveRecord::Migration
  def change
    # Parents
    # Change grade from string(??? why) to integer
    # "Piano home?" from string(??? again why) to boolean
    # "Past app?" from string to boolean (WHY pastapp NOT past_app LIKE EVERYTHING ELSE)
    # "Lunch?" from string to boolean
    add_column :parents, :grade_tmp, :integer
    add_column :parents, :piano_home_tmp, :boolean
    add_column :parents, :past_app_tmp, :boolean
    add_column :parents, :lunch_tmp, :boolean
    Parent.reset_column_information
    Parent.all.each do |parent|
      parent.grade_tmp = parent.grade.to_i
      parent.piano_home_tmp = (parent.piano_home == "t" ? true : false)
      parent.past_app_tmp = (parent.pastapp == "t" ? true : false)
      parent.lunch_tmp = (parent.lunch == "t" ? true : false)
      parent.save
    end
    remove_column :parents, :grade
    rename_column :parents, :grade_tmp, :grade
    remove_column :parents, :piano_home
    rename_column :parents, :piano_home_tmp, :piano_home
    remove_column :parents, :pastapp
    rename_column :parents, :past_app_tmp, :past_app
    remove_column :parents, :lunch
    rename_column :parents, :lunch_tmp, :lunch
    Parent.reset_column_information
    
    # Teachers
    # Change grade from string to integer
    add_column :teachers, :grade_tmp, :integer
    Teacher.reset_column_information
    Teacher.all.each do |teacher|
      teacher.grade_tmp = teacher.grade.to_i
    end
    Teacher.reset_column_information
    remove_column :teachers, :grade
    rename_column :teachers, :grade_tmp, :grade
    
    # Tutors
    # SID to integer
    # in_class to boolean
    # private to boolean
    # returning to boolean
    # prev_again to boolean
    add_column :tutors, :sid_tmp, :integer
    add_column :tutors, :in_class_tmp, :boolean
    add_column :tutors, :private_tmp, :boolean
    add_column :tutors, :returning_tmp, :boolean
    add_column :tutors, :prev_again_tmp, :boolean
    Tutor.reset_column_information
    Tutor.all.each do |tutor|
      tutor.sid_tmp = tutor.sid.to_i
      tutor.in_class_tmp = (tutor.in_class == "t" ? true : false)
      tutor.private_tmp = (tutor.private == "t" ? true : false)
      tutor.returning_tmp = (tutor.returning == "t" ? true : false)
      tutor.prev_again_tmp = (tutor.prev_again == "t" ? true : false)
    end
    Tutor.reset_column_information
    remove_column :tutors, :sid
    rename_column :tutors, :sid_tmp, :sid
    remove_column :tutors, :in_class
    rename_column :tutors, :in_class_tmp, :in_class
    remove_column :tutors, :private
    rename_column :tutors, :private_tmp, :private
    remove_column :tutors, :returning
    rename_column :tutors, :returning_tmp, :returning
    remove_column :tutors, :prev_again
    rename_column :tutors, :prev_again_tmp, :prev_again

  end
end
