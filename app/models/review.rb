class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true
  validates :comment, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
