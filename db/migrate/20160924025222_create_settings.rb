class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :ems_login
      t.string :ems_password
      t.text :sender_address
      t.string :content

      t.timestamps null: false
    end
  end
end
