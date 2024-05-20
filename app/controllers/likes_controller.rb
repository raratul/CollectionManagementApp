class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item
  
    def create
      @like = @item.likes.build(user: current_user)
      if @like.save
        respond_to do |format|
          format.html { redirect_to [@item.collection, @item], notice: 'Item liked.' }
          format.js
        end
      else
        redirect_to [@item.collection, @item], alert: 'Unable to like item.'
      end
    end
  
    def destroy
      @like = @item.likes.find_by(user: current_user)
      if @like.destroy
        respond_to do |format|
          format.html { redirect_to [@item.collection, @item], notice: 'Like removed.' }
          format.js
        end
      else
        redirect_to [@item.collection, @item], alert: 'Unable to remove like.'
      end
    end
  
    private
  
    def set_item
      @item = Item.find(params[:item_id])
    end
end
  