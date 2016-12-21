class AddIsProcessedToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_processed, :boolean, default: false
  end
end
