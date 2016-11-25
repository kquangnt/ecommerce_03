class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: :show

  def index
    @users = User.order_date_desc.page(params[:page]).
      per Settings.per_page.user
  end

  def show
  end
end
