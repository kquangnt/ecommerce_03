class Admin::CategoriesController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    @categories = Category.order_date_desc.page(params[:page])
      .per Settings.per_page.category
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category_created_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category_updated_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "success_delete_category"
    else
      flash[:danger] = t "fail_delete_category"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
