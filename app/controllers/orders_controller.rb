class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :list_categories
  load_and_authorize_resource

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
      @order = Order.new order_params
      if @order.save
        redirect_to orders_path
        flash[:success] = t "order.your_order_is_sent_successfully"
        @cart = Cart.create
        session[:cart_id] = @cart.id
      else
        render :new
      end
    end
  end

  def index
    @orders = Order.filter_user(current_user.id).order_date_desc.page(params[:page])
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
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit(:is_accept, :cart_id)
      .merge! user_id: current_user.id, cost: current_cart.total_price
  end
end
