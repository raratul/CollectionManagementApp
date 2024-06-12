class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @tickets = @user.tickets.order(created_at: :desc).page(params[:page]).per(10)
  end

  def regenerate_api_token
    current_user.regenerate_api_token
    redirect_to profile_path, notice: 'API token has been regenerated.'
  end
end
