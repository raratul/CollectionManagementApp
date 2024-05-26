class HomeController < ApplicationController
  def index
    @latest_items = Item.order(created_at: :desc).limit(5)

    @top_collections = Collection.left_joins(:items).group(:id).order('COUNT(items.id) DESC').limit(5)

    @tag_cloud = Item.pluck(:tag).join(',').split(',').uniq
  end
end
