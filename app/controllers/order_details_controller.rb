class OrderDetailsController < ApplicationController
  #before_action :load_order_detail, only: [:show, :edit, :update, :destroy]
  before_action :load_book, only: [:new, :create, :destroy]

  def show
  end

  def new
    @order_detail = OrderDetail.new
  end

  def edit
  end

  def create
    @cart = current_cart
    if params[:number]
      @order_detail = OrderDetail.new number: params[:number]
    else
      @order_detail = OrderDetail.new order_detail_params
    end
    @order_detail = @cart.add_book(@order_detail.number, @book.id)
    @order_detail.unit_price_current = @book.unit_price

    if @order_detail.save
      flash[:success] = t "add_book_successfully"
      redirect_to @order_detail.cart
    else
      render :new
    end

  end

  def update
    respond_to do |format|
      if @order_detail.update(order_detail_params)
        format.html {redirect_to @order_detail, notice: "order detail was successfully updated."}
        format.json {render :show, status: :ok, location: @order_detail}
      else
        format.html {render :edit}
        format.json {render json: @order_detail.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @order_detail = OrderDetail.find_by cart_id: current_cart.id, book_id: @book.id
    if @order_detail
      if @order_detail.destroy
        flash[:success] = t "success_delete_order_detail"
      else
        flash[:danger] = t "fail_delete_order_detail"
      end
    else
      flash[:danger] = t "order_detail_not_exist"
    end
    redirect_to cart_path current_cart
  end

  private
  def load_order_detail
    @order_detail = OrderDetail.find_by_id params[:id]
    unless @order_detail
      flash[:danger] = t "order_detail_not_exist"
      redirect_to cart_path current_cart
    end
  end

  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:danger] = t "book_not_exist"
      redirect_to cart_path current_cart
    end
  end

  def order_detail_params
    params.require(:order_detail).permit :number
  end
end
