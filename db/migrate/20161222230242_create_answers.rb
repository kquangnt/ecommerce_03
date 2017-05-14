class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :content
      t.integer :user_id
      t.integer :book_id
      t.integer :review1_id

      t.timestamps
    end
  end
end
