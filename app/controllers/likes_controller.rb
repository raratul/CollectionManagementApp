class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item
  
    def create
      @item.likes.create(user: current_user)
      respond_to do |format|
        format.html { redirect_to @item }
        format.js
      end
    end
  
    def destroy
      @item.likes.find_by(user: current_user)&.destroy
      respond_to do |format|
        format.html { redirect_to @item }
        format.js
      end
    end
  
    private
  
    def set_item
      @item = Item.find(params[:item_id])
    end
end
  