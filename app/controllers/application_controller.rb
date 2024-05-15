class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def toggle_theme
    cookies[:theme] = params[:theme]
    render json: { status: 'ok' }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :status])
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
  end
end


