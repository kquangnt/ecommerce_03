class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :book
  belongs_to :comment

  validates :content, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
