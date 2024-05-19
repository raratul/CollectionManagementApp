class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authenticate_admin!, except: [:index, :show]
  before_action :set_collection, only: %i[show edit update destroy]

  def index
    @collections = current_user.collections
  end

  def show
    @items = @collection.items
  end

  def new
    @collection = current_user.collections.build
  end

  def create
    @collection = current_user.collections.build(collection_params)
    if @collection.save
      redirect_to @collection, notice: 'Collection was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @collection.update(collection_params)
      redirect_to @collection, notice: 'Collection was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @collection.destroy
    redirect_to collections_url, notice: 'Collection was successfully destroyed.'
  end

  private

  def set_collection
    @collection = current_user.collections.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :image_url, :category, :custom_string1_state, :custom_string1_name, :custom_string2_state, :custom_string2_name, :custom_string3_state, :custom_string3_name, :custom_int1_state, :custom_int1_name, :custom_int2_state, :custom_int2_name, :custom_int3_state, :custom_int3_name, :custom_text1_state, :custom_text1_name, :custom_text2_state, :custom_text2_name, :custom_text3_state, :custom_text3_name, :custom_bool1_state, :custom_bool1_name, :custom_bool2_state, :custom_bool2_name, :custom_bool3_state, :custom_bool3_name, :custom_date1_state, :custom_date1_name, :custom_date2_state, :custom_date2_name, :custom_date3_state, :custom_date3_name)
  end
end
