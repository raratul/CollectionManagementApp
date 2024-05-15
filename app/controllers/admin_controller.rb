class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end
  
  def batch_action
    if params[:block_users]
      User.where(id: params[:user_ids]).update_all(blocked: true)
      flash[:notice] = "Selected users have been blocked."
    elsif params[:unblock_users]
      User.where(id: params[:user_ids]).update_all(blocked: false)
      flash[:notice] = "Selected users have been unblocked."
    elsif params[:delete_users]
      User.where(id: params[:user_ids]).destroy_all
      flash[:notice] = "Selected users have been deleted."
    elsif params[:add_admins]
      User.where(id: params[:user_ids]).update_all(admin: true)
      flash[:notice] = "Selected users are now admins."
    elsif params[:remove_admins]
      User.where(id: params[:user_ids]).update_all(admin: false)
      flash[:notice] = "Selected users are no longer admins."
    end
    redirect_to admin_path
  end
end
