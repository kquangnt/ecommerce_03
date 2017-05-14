class Review1 < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :answers, dependent: :destroy

  validates :rating1, presence: true
  validates :comment1, presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
