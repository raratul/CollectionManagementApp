class ApplicationController < ActionController::Base
  before_action :set_theme
  before_action :set_locale

  def set_theme
    @theme = if user_signed_in?
               current_user.theme || 'light'
             else
               session[:theme] || 'light'
             end
  end

  def set_locale
    I18n.locale = if user_signed_in?
                    current_user.locale || I18n.default_locale
                  else
                    session[:locale] || I18n.default_locale
                  end
  end

  def toggle_theme
    new_theme = params[:theme] == 'dark' ? 'dark' : 'light'
    if user_signed_in?
      current_user.update(theme: new_theme)
    else
      session[:theme] = new_theme
    end
    head :ok
  end

  def toggle_language
    new_locale = I18n.locale == :en ? :pl : :en
    if user_signed_in?
      current_user.update(locale: new_locale)
    else
      session[:locale] = new_locale
    end
    redirect_back fallback_location: root_path
  end

  private

  def authenticate_admin!
    redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
  end
end


