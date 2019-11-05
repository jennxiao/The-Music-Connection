class IncreaseSidIntegerSize < ActiveRecord::Migration
  def change
    change_column :tutors, :sid, :integer, limit: 8
  end
end
