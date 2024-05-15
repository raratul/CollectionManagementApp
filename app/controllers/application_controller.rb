class ApplicationController < ActionController::Base
  before_action :set_theme

  def toggle_theme
    if user_signed_in?
      current_user.update(theme: params[:theme])
    else
      session[:theme] = params[:theme]
    end
    render json: { status: 'ok' }
  end

  private

  def set_theme
    theme = user_signed_in? ? current_user.theme : session[:theme]
    theme ||= 'light'
    @theme = theme
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
  end
end


