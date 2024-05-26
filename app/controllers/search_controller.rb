class SearchController < ApplicationController
  def index
    if params[:query].present?
      @resultcollection = Collection.search(params[:query])
      @resultitem = Item.search(params[:query])
    else
      @resultcollection = Collection.none
      @resultitem = Item.none
    end
  end
end
