class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :review1

  validates :content, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
  scope :filter_review1, ->review1_id do
    where review1_id: review1_id
  end
end
