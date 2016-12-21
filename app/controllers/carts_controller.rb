class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :list_categories
  load_and_authorize_resource

  def index
  end

  def show
    unless (@cart.id == current_cart.id)
      redirect_to orders_path, notice: t("you_can_only_view_the_current_cart")
    end
  end

  def new
    @cart = Cart.new
  end

  def destroy
    @cart = current_cart
    if @cart.destroy
      session[:cart_id] = nil
      flash[:success] = t "success_delete_cart"
    else
      flash[:danger] = t "fail_delete_cart"
    end
    redirect_to cart_path current_cart
  end

  private
  def cart_params
    params.fetch :cart, {}
  end
end
