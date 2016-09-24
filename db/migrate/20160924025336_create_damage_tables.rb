class CreateDamageTables < ActiveRecord::Migration
  def change
    create_table :damage_tables do |t|
      t.integer :min
      t.integer :max
      t.integer :damages

      t.timestamps null: false
    end
  end
end
