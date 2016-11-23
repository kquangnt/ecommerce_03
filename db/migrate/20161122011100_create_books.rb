class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.integer :unit_price
      t.integer :category_id

      t.timestamps
    end
  end
end
