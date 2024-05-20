class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def create
    @comment = @item.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      ActionCable.server.broadcast "comments_#{@item.id}", comment_partial: render_to_string(@comment)
      head :ok
      # respond_to do |format|
      #   format.html { redirect_to [@item.collection, @item], notice: 'Comment was successfully created.' }
      #   format.js
      # end
    else
      render 'items/show'
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
