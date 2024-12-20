class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :address])
  end

  protected

  def after_sign_out_path_for(_resource)
    session.delete("user_return_to")
    root_path
  end
end
