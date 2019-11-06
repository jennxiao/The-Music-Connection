class AddEmailAndSessionToAdminSettings < ActiveRecord::Migration
  def change
    add_column :admin_settings, :email,      :string
    add_column :admin_settings, :session_id, :string
  end
end
