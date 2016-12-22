class RatingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!
  before_action :list_categories
  before_action :load_book
  load_and_authorize_resource

  def create
    @rating = Rating.new rating_params
    if @rating.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error_rating_fail"
      redirect_to root_path
    end
  end

  def update
    @rating = Rating.find_by book_id: @book.id, user_id: current_user.id
    if @rating.update_attributes rating_params
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error_edit_rating_fail"
      redirect_to root_path
    end
  end

  private
  def rating_params
    params.require(:rating).permit(:rating)
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
