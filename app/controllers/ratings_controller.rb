class RatingsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!
  before_action :list_categories
  before_action :load_book
  load_and_authorize_resource

  def create
    @rating = Rating.new rating_params
    @rating.save
    redirect_to book_path @book
  end

  def edit
  end

  def update
    if @rating.update
      flash[:success] = t "update_rating_successfully"
      redirect_to book_path @book_path
    else
      render :edit
    end
  end

  def destroy
    @rating.destroy
    redirect_to book_path @book
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
