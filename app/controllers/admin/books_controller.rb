class Admin::BooksController < ApplicationController
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
        redirect_to admin_books_path
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "success_delete_book"
    else
      flash[:danger] = t "fail_delete_book"
    end
    redirect_to admin_books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :description, :unit_price,
      :category_id, :book_img).merge category_id: params[:category_id]
  end
end