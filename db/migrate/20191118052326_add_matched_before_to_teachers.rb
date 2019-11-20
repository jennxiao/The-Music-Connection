class AddMatchedBeforeToTeachers < ActiveRecord::Migration
  def change
    add_column :teachers, :matched_before, :boolean
  end
end
