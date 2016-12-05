class Category < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true

  scope :order_date_desc, ->{order created_at: :desc}
end
