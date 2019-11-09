class ProperlyStoreForeignKeysInMatchesDb < ActiveRecord::Migration
  def change
    add_reference :matches, :tutors
    add_reference :matches, :teachers
    add_reference :matches, :parents
    
    remove_column :matches, :tutor_id
    remove_column :matches, :tutee_id
    remove_column :matches, :color    
  end
end
