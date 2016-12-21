class Admin::OrdersController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    @orders = Order.order_date_desc.page(params[:page])
      .per Settings.per_page.order
  end

  def show
    @cart = Cart.find_by_id(@order.cart_id)
  end

  def destroy
    if @order.destroy
      flash[:success] = t "success_delete_order"
    else
      flash[:danger] = t "fail_delete_order"
    end
    redirect_to admin_orders_path
  end
end
