class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :order_id
      t.string :ship_to
      t.string :phone
      t.integer :price
      t.float :rate
      t.integer :damages

      t.timestamps null: false
    end
  end
end
