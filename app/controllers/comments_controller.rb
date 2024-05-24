class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_item, only: [:create, :destroy]
  
    def create
      @comment = @item.comments.build(comment_params)
      @comment.user = current_user
      if @comment.save
        respond_to do |format|
          format.html { redirect_to @item }
          format.js
        end
      else
        render 'items/show'
      end
    end
  
    def destroy
        @comment = @item.comments.find(params[:id])
        if @comment.user == current_user || current_user.admin?
          @comment.destroy
          respond_to do |format|
            format.html { redirect_to @item }
            format.js
          end
        else
          head :forbidden
        end
    end      
  
    private
  
    def set_item
      @item = Item.find(params[:item_id])
    end
  
    def comment_params
      params.require(:comment).permit(:body)
    end
end
  