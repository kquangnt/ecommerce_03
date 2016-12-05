class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :list_categories, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit :name, :telephone, :email, :password, :password_confirmation
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit :name, :telephone, :email, :password,
        :password_confirmation, :current_password
    end
  end

  def list_categories
    @categories_header = Category.all
  end
end
