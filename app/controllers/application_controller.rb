class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :list_categories, if: :devise_controller?
  before_action :current_cart, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :name, :telephone, :email, :password, :password_confirmation
    end
  end

  def load_user
    @user = User.find_by_id params[:id]
    unless @user
      flash[:danger] = t "user_not_exist"
      redirect_to users_path
    end
  end

  def list_categories
    @categories_header = Category.all
  end

  #def list_books
  #  @books_home = Book.all.page(params[:page]).per Settings.per_page.book_home
  #end

  def current_cart
    Cart.find session[:cart_id]
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  helper_method :current_cart
end
