class AdminController < ApplicationController
    before_action :authenticate_admin!
  
    def index
      @users = User.all
    end
  
    def block_user
      user = User.find(params[:id])
      user.update(blocked: true)
      redirect_to admin_path, notice: "#{user.email} has been blocked."
    end
  
    def unblock_user
      user = User.find(params[:id])
      user.update(blocked: false)
      redirect_to admin_path, notice: "#{user.email} has been unblocked."
    end
  
    def delete_user
      user = User.find(params[:id])
      user.destroy
      redirect_to admin_path, notice: "#{user.email} has been deleted."
    end
  
end
  