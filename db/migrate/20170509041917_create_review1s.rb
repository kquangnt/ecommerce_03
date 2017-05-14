class CreateReview1s < ActiveRecord::Migration[5.0]
  def change
    create_table :review1s do |t|
      t.integer :rating1
      t.text :comment1
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
