class RegistrationsController < Devise::RegistrationsController
    # def create
    #   super do |resource|
    #     resource.admin = true if !User.first_admin? && resource.admin?
    #   end
    # end
    protected

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  
    def after_sign_up_path_for(resource)
      if User.first_admin?
        resource.update(admin: true)
      end
      super(resource)
    end
end
  