class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :load_user, only: [:show, :destroy]

  def index
    @users = User.order_date_desc.page(params[:page]).
      per Settings.per_page.user
  end

  def show
  end

  def destroy
    if @user.destroy
      flash[:success] = t "delete_success"
    else
      flash[:danger] = t "delete_fails"
    end
    redirect_to admin_users_url
  end
end
