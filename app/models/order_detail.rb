class OrderDetail < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  scope :order_date_desc, ->{order created_at: :desc}
  scope :filter_order_details, ->{where "number > 1"}
  scope :filter_book, ->book_id do
    where book_id: book_id
  end

  def total_price
    unit_price_current * number
  end
end
