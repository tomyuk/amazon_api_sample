class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string	:session_id,		null: false		# セッションID
      t.text	:data,			null: false		# セッションデータ
      t.timestamps null: false

      t.index :session_id, unique: true
      t.index :updated_at
    end
  end
end
