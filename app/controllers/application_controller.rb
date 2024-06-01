class ApplicationController < ActionController::Base
  before_action :set_theme
  before_action :set_language

  def set_theme
    theme = user_signed_in? ? current_user.theme : session[:theme]
    theme ||= 'light'
    @theme = theme
  end

  def set_language
    I18n.locale = current_user&.language || session[:language] || I18n.default_locale
  end

  def toggle_language
    new_language = I18n.locale == :en ? :pl : :en
    if user_signed_in?
      current_user.update(language: new_language)
    else
      session[:language] = new_language
    end
    redirect_back fallback_location: root_path
  end

  def toggle_theme
    new_theme = @theme == 'dark' ? 'light' : 'dark'
    if user_signed_in?
      current_user.update(theme: new_theme)
    else
      session[:theme] = new_theme
    end
    redirect_back fallback_location: root_path
  end

  private

  def blocked_user!
    if current_user&.blocked?
      sign_out current_user
      redirect_to root_path, alert: "Your account has been blocked. Please contact the administrator."
    end
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
  end
end


