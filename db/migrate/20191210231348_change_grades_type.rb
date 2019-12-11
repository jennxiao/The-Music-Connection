class ChangeGradesType < ActiveRecord::Migration
  def change
	  change_column :parents, :grade, :string
	  change_column :teachers, :grade, :string
	  add_column :tutors, :grade, :string
  end
end
