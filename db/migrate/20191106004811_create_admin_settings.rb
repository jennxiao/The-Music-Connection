class CreateAdminSettings < ActiveRecord::Migration
  def change
    create_table :admin_settings do |t|
      t.boolean :form_open
      t.string :salt
      t.string :password_hash
      t.datetime :last_updated
    end
  end
end
