class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @tickets = @user.tickets.order(created_at: :desc).page(params[:page]).per(10)
  end
end
