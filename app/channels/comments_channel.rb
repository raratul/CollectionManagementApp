class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comments_#{params['item_id']}"
  end

  def unsubscribed
  end
end
