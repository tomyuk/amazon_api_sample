class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string		:ems_login,			null: false, default: ''
      t.string		:ems_password,			null: false, default: ''
      t.string		:content,			null: false, default: ''

      t.timestamps					null: false
    end
  end
end
