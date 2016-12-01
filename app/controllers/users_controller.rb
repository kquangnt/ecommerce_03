class UsersController < ApplicationController
  before_action :list_categories
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.order_date_desc.page(params[:page]).
      per Settings.per_page.user
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "success_delete_user"
    else
      flash[:danger] = t "fail_delete_user"
    end
    redirect_to users_url
  end
end
