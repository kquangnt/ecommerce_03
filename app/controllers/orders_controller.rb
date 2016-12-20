class OrdersController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    @orders = Order.filter_user(current_user.id).created_desc.page(params[:page])
      .per Settings.per_page.order
  end

  def new
    if current_user.blank?
      redirect_to new_user_session_path
    else
      @order = Order.new
    end
  end

  def create
    if current_cart.order_details.blank?
      redirect_to root_path, notice: t("your_cart_is_empty")
    else
      order = Order.new order_params
      if @order.save
        flash[:success] = t "order.your_order_is_send_successfully"
        @cart = Cart.create
        session[:cart_id] = @cart.id
        redirect_to orders_path
      else
        render :new
      end
    end
  end

  def show
    @cart = Cart.find_by id: @order.cart_id
    unless @cart
      flash[:danger] = t "cart_not_exist"
      redirect_to orders_path
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "success_delete_order"
    else
      flash[:danger] = t "fail_delete_order"
    end
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit(:is_accept, :cart_id)
      .merge! user_id: current_user.id, cost: current_cart.total_price
  end
end
