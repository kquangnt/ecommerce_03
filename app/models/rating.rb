class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
