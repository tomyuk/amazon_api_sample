class CreateSystemLogs < ActiveRecord::Migration
  def change
    create_table :system_logs do |t|
      t.string		:event,			null: false, default: ''
      t.string		:client,		null: false, default: ''
      t.string		:browser,		null: false, default: ''

      t.timestamps				null: false
    end
  end
end
