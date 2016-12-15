class CartsController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    @cart = Cart.find_by id: current_cart.id
    unless @cart
      flash[:danger] = t "cart_not_exist"
      redirect_to books_path
    end
  end

  def show
    unless @cart.id == current_cart.id
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
      flash[:danger] = t "your_cart_is_currently_empty_continue_shopping"
    end
    redirect_to books_path
  end

  private
  def cart_params
    params.fetch :cart, {}
  end
end
