class Category < ApplicationRecord
  has_many :books
  has_many :books, dependent: :destroy

  validates :name, presence: true

  scope :order_date_desc, ->{order created_at: :desc}

  def self.search(category_input)
    where("name LIKE ?", "%#{category_input}%")
  end
end
