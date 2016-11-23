class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cost
      t.boolean :is_accept

      t.timestamps
    end
  end
end
