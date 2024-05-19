class HomeController < ApplicationController
    def index
      @latest_items = Item.order(created_at: :desc).limit(10)
      @largest_collections = Collection.left_joins(:items).group(:id).order('COUNT(items.id) DESC').limit(5)
    #   @tag_cloud = Tag.joins(:taggings).group(:name).order('COUNT(taggings.tag_id) DESC').limit(30)
    end
end
  