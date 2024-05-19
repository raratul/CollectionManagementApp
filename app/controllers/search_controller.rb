class SearchController < ApplicationController
    def index
      if params[:query].present?
        @results = Item.search(params[:query])
      else
        @results = Item.none
      end
    end
end
  