class AddViewCountToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :view_count, :number, default: 0
  end
end
