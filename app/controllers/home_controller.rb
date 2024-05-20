class HomeController < ApplicationController
  def index
    @latest_items = Item.order(created_at: :desc).limit(10)

    @top_collections = Collection.left_joins(:items).group(:id).order('COUNT(items.id) DESC').limit(5)

    @tag_cloud = ActsAsTaggableOn::Tag.most_used(20)

    @tag_cloud ||= []
  end
end
