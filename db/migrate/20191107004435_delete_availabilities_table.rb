class DeleteAvailabilitiesTable < ActiveRecord::Migration
  def change
    drop_table :availabilities
  end
end
