class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.integer :order_id
      t.integer :book_id
      t.integer :number
      t.integer :total_price

      t.timestamps
    end
  end
end
