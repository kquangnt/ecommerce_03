class Cart < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_one :order

  scope :order_date_desc, ->{order created_at: :desc}

  def add_book number_input, book_id
    current_item = order_details.find_by_book_id book_id
    if current_item
      current_item.increment :number, number_input
    else
      current_item = order_details.build book_id: book_id
      current_item.increment :number, number_input - 1
    end
  end

  def total_price
    order_details.to_a.sum {|item| item.total_price}
  end
end
