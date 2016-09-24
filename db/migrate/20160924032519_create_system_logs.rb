class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.string :event
      t.string :client
      t.string :browser

      t.timestamps null: false
    end
  end
end
