class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    #before_action :authenticate_admin!
    before_action :configure_permitted_parameters, if: :devise_controller?

    # protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

    private
  
    def authenticate_admin!
      redirect_to root_path, alert: "You are not authorized to access this page." unless current_user&.admin?
    end
end
  