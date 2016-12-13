class ReviewsController < ApplicationController
  before_action :list_categories
  before_action :load_book
  load_and_authorize_resource

  def new
    if current_user.blank?
      redirect_to new_user_session_path
    else
      @review = Review.new
    end
  end

  def create
    @review = Review.new review_params
    if @review.save
      redirect_to book_path @book
    else
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment)
      .merge! book_id: @book.id, user_id: current_user.id
  end

  def load_book
    @book = Book.find_by_id params[:book_id]
    unless @book
      flash[:danger] = t "book_not_exist"
      redirect_to books_path
    end
  end
end
