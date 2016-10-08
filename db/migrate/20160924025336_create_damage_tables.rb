class CreateDamageTables < ActiveRecord::Migration
  def change
    create_table :damage_tables do |t|
      t.integer		:min,			null: false, default: 0
      t.integer		:max,			null: false, default: 0
      t.integer		:damages,		null: false, default: 0

      t.timestamps				null: false
    end
  end
end
