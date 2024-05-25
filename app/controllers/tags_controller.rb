class TagsController < ApplicationController
  def autocomplete
    tags = Item.pluck(:tag).join(',').split(',').uniq
    render json: tags
  end
end
