class AnswersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :list_categories
  before_action :load_book
  before_action :load_review1
  load_and_authorize_resource

  def index
    list_answers
    @answer = Answer.new
    respond_to do |format|
      format.js
    end
  end

  def create
    #@answer = Answer.new answer_params
    if @answer.save
      list_answers
      @answer = Answer.new answer_params
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "error_create_answer"
      redirect_to book_path @book
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    if @answer.update_attributes answer_params
      list_answers
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "answer_updated_fails"
      redirect_to book_path @book
    end
  end

  def destroy
    if @answer.destroy
      list_answers
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t "answer_updated_fails"
      redirect_to book_path @book
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:content)
      .merge review1_id: @review1.id, book_id: @book.id, user_id: current_user.id
  end

  def load_book
    @book = Book.find_by_id params[:book_id]
    unless @book
      flash[:danger] = t "book_not_exist"
      redirect_to books_path
    end
  end

  def load_review1
    @review1 = Review1.find_by_id params[:review1_id]
    unless @review1
      flash[:danger] = t "comment_not_exist"
      redirect_to book_path @book
    end
  end

  def list_answers
    load_book
    @answers = @book.answers.order_date_desc
  end
end
