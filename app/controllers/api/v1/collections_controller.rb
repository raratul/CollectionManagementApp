class Api::V1::CollectionsController < ApplicationController
  before_action :authenticate_with_token!

  def index
    @collections = current_user.collections
    render json: @collections, status: :ok
  end

  private

  def authenticate_with_token!
    token = request.headers['Authorization']
    @current_user = User.find_by(api_token: token)

    render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
  end

  def current_user
    @current_user
  end
end
