class Admin::OrdersController < ApplicationController
  before_action :list_categories
  #before_action :load_order, only: [:update]
  load_and_authorize_resource

  def index
    @orders = Order.created_desc.page(params[:page])
      .per Settings.per_page.order
    respond_to do |format|
      format.html
      format.xls
      format.csv {send_data @order.to_csv}
    end
  end

  def show
    @cart = Cart.find_by_id(@order.cart_id)
  end

  def update
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "order_not_exist"
      redirect_to admin_orders_path
    end
    #if @order.try(:update_attributes, order_params)
    if @order.update_attributes order_params
      flash[:success] = t "order_updated_success"
      redirect_to admin_orders_path
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "success_delete_order"
    else
      flash[:danger] = t "fail_delete_order"
    end
    redirect_to admin_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:is_processed)
  end

  def load_order
    @order = Order.find_by id: params[:order_id]
    unless @order
      flash[:danger] = t "oredr_not_exist"
      redirect_to admin_orders_path
    end
  end
end
