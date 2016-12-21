class AddCartIdToOrderDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :order_details, :cart_id, :integer
  end
end
