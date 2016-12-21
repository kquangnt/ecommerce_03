class CombineItemsInCart < ActiveRecord::Migration[5.0]
  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.order_details.group(:book_id).sum(:number)
      sums.each do |book_id, number|
        if number > 1
          # remove individual items
          cart.order_details.filter_book(book_id).delete_all
          # replace with a single item
          cart.order_details.create book_id: book_id, number: number
        end
      end
    end
  end

  def down
    # split items with quantity>1 into multiple items
    OrderDetail.filter_order_detail.each do |order_detail|
      # add individual items
      order_detail.number.times do
      OrderDetail.create cart_id: order_detail.cart_id,
        book_id: order_detail.book_id, number: 1
      end
      # remove original item
      order_detail.destroy
    end
  end
end
