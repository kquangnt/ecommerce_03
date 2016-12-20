class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def up
    Cart.all.each do |cart|
      sums = cart.order_details.group(:book_id).sum :number
      sums.each do |book_id, number|
        if number > 1
          cart.order_details.filter_book(book_id).delete_all
          cart.order_details.create book_id: book_id, number: number
        end
      end
    end
  end

  def down
    OrderDetail.filter_order_details.each do |order_detail|
      order_detail.number.times do
        OrderDetail.create cart_id: order_detail.cart_id,
          book_id: order_detail.book_id, number: 1
      end
      order_detail.destroy
    end
  end
end
