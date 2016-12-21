class BooksController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    if params[:category].blank?
      @books = Book.order_view_count_desc.page(params[:page])
        .per Settings.per_page.book
    else
      @category = Category.find_by_id params[:category]
      if @category
        @books = Book.filter_category(@category.id).order_view_count_desc.page(params[:page])
          .per Settings.per_page.book
      else
        flash[:danger] = t "category_not_exist"
        redirect_to books_path
      end
    end
  end

  def show
    @order_detail = OrderDetail.new
    @comments = @book.comments.order_date_desc.page(params[:page]).per Settings.per_page.comment
    @ratings = @book.ratings.order_date_desc.page(params[:page])
      .per Settings.per_page.rating
    if @ratings.blank?
      @average_review = 0
    else
      @average_review = @book.ratings.average(:rating).round Settings.average_round
    end
    @book.increment :view_count
    @book.save!
  end
end
