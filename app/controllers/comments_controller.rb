class CommentsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!
  before_action :list_categories
  before_action :load_book
  load_and_authorize_resource

  def create
    @comment = Comment.new comment_params
    @comment.save
    redirect_to book_path @book
  end

  def destroy
    @comment.destroy
    redirect_to book_path @book
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
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
