class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item

  def create
    unless @item.liked_by?(current_user)
      @item.likes.create(user: current_user)
    end
    redirect_to collection_item_path(@item.collection, @item)
  end

  def destroy
    if @item.liked_by?(current_user)
      @item.likes.find_by(user: current_user).destroy
    end
    redirect_to collection_item_path(@item.collection, @item)
  end

  private

  def find_item
    @item = Item.find(params[:item_id])
  end
end
