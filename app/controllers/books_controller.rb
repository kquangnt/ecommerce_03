class BooksController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    if params[:category].blank?
      @books = Book.order_date_desc.page(params[:page])
        .per Settings.per_page.book
    else
      @category = Category.find_by_id params[:category]
      if @category
        @books = Book.filter_category(@category.id).order_date_desc.page(params[:page])
          .per Settings.per_page.book
      else
        flash[:danger] = t "category_not_exist"
        redirect_to books_path
      end
    end
  end

  def show
    @order_detail = OrderDetail.new
    @reviews = @book.reviews.order_date_desc.page(params[:pages])
      .per Settings.per_page.review
    if @reviews.blank?
      @average_review = Settings.zero
    else
      @average_review = @book.reviews.average(:rating).round Settings.average_round
    end
  end
end
