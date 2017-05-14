class Review1sController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :list_categories
  before_action :load_book
  load_and_authorize_resource

  def create
    @review1 = Review1.new review1_params
    @review1.book_id = @book.id
    @review1.user_id = current_user.id
    @review1.save
    redirect_to book_path @book
  end

  def destroy
    @review1.destroy
    redirect_to book_path @book
  end

  private
  def review1_params
    params.require(:review1).permit :rating1, :comment1
  end

  def load_book
    @book = Book.find_by_id params[:book_id]
    unless @book
      flash[:danger] = t "book_not_exist"
      redirect_to books_path
    end
  end
end
