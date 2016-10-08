class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string		:shop,			null: false, default: ''
      t.string		:order_id,		null: false, default: ''
      t.string		:ship_to,		null: false, default: ''
      t.string		:phone,			null: false, default: ''
      t.integer		:price,			null: false, default: 0
      t.float		:rate,			null: false, default: 1.0
      t.integer		:damages,		null: false, default: 0

      t.timestamp	:ordered_at
      t.timestamps				null: false

      t.index		[ :shop, :order_id ],	unique: true
      t.index		:ship_to
    end
  end
end
