class DeleteTutorGradeCol < ActiveRecord::Migration
  def change
	  remove_column :tutors, :grade, :string
  end
end
