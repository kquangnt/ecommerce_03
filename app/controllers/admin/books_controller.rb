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

  def show
    @category = Category.find_by_id @book.category_id
    @review1s = @book.review1s.order_date_desc.page(params[:page])
      .per Settings.per_page.review1
    if @review1s.blank?
      @average_review1 = 0
    else
      @average_review1 = @book.review1s.average(:rating1).round Settings.average_round
    end
    unless @category
      flash[:danger] = t "category_not_exist"
      redirect_to books_path
    end
  end

  def edit
  end

  def update
    if @book.update edit_book_params
      flash[:success] = t "book_updated_success"
      redirect_to admin_book_path @book
    else
      render :edit
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
      :category_id, :book_img).merge(category_id: params[:category_id])
  end

  def edit_book_params
    params.require(:book).permit :title, :author, :description, :unit_price,
      :category_id, :book_img
  end
end
