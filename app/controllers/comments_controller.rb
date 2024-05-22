# class CommentsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_item

#   def create
#     @comment = @item.comments.build(comment_params)
#     @comment.user = current_user
#     if @comment.save
#       # ActionCable.server.broadcast "comments_#{@item.id}", comment_partial: render_to_string(@comment)
#       head :ok
#     else
#       render 'items/show'
#     end
#   end

#   private

#   def set_item
#     @item = Item.find(params[:item_id])
#   end

#   def comment_params
#     params.require(:comment).permit(:body)
#   end
# end

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @item.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      render json: { comment: render_to_string(partial: 'comments/comment', locals: { comment: @comment }) }
    else
      render json: { error: @comment.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: { comment: @comment }
    else
      render json: { error: @comment.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: { comment: @comment }
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_comment
    @comment = @item.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
