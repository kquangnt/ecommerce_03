class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.integer :unit_price_current
      t.integer :book_id
      t.integer :number, default: 1
      t.integer :total_price

      t.timestamps
    end
  end
end
