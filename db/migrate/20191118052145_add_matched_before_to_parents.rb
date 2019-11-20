class AddMatchedBeforeToParents < ActiveRecord::Migration
  def change
    add_column :parents, :matched_before, :boolean
  end
end
