class CategoriesController < ApplicationController
  before_action :list_categories
  load_and_authorize_resource

  def index
    @categories = Category.order_date_desc.page(params[:page])
      .per Settings.per_page.category
  end
end
