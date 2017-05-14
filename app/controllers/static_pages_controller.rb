class StaticPagesController < ApplicationController
  before_action :list_categories

  def home
    if params[:category_id].nil?
      @books_home = Book.order_view_count_desc.page(params[:page])
        .per Settings.per_page.book
    else
      if (params[:category_id].empty? && params[:search2].empty?)
        @books_home = Book.search(params[:search1]).order_view_count_desc.page(params[:page])
          .per Settings.per_page.book
      else
        if params[:category_id].empty?
          @books_home = Book.search(params[:search1], params[:search2])
            .order_view_count_desc.page(params[:page]).per Settings.per_page.book
        else
          if params[:search2].empty?
            @books_home = Book.search(params[:search1], Settings.ky_tu_rong, params[:category_id])
              .order_view_count_desc.page(params[:page]).per Settings.per_page.book
          else
            @books_home = Book.search(params[:search1], params[:search2], params[:category_id])
              .order_view_count_desc.page(params[:page]).per Settings.per_page.book
          end
        end
      end
    end
  end
end
