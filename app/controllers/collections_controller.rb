class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :all_collections]
  before_action :authenticate_admin!, except: [:show, :index, :new, :create, :all_collections]
  before_action :set_collection, only: [:show, :edit, :update, :destroy]

  def index
    @collections = current_user.collections
  end

  def show
    @items = @collection.items
  end

  def new
    if current_user.admin?
      @collection = Collection.new
    else
      @collection = current_user.collections.build
    end
  end

  def all_collections
    @collections = Collection.all
  end

  def create
    if current_user.admin?
      @collection = Collection.new(collection_params_for_admin)
    else
      @collection = current_user.collections.build(collection_params)
    end
    set_custom_field_states(@collection)
    if @collection.save
      redirect_to @collection, notice: 'Collection was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    set_custom_field_states(@collection)
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
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description, :category, :image_url,
                                       :custom_string1_name, :custom_string2_name, :custom_string3_name,
                                       :custom_int1_name, :custom_int2_name, :custom_int3_name,
                                       :custom_text1_name, :custom_text2_name, :custom_text3_name,
                                       :custom_boolean1_name, :custom_boolean2_name, :custom_boolean3_name,
                                       :custom_date1_name, :custom_date2_name, :custom_date3_name)
  end

  def collection_params_for_admin
    params.require(:collection).permit(
      :name, :description, :category, :user_id, :image_url,
      :custom_string1_name, :custom_string2_name, :custom_string3_name,
      :custom_int1_name, :custom_int2_name, :custom_int3_name,
      :custom_text1_name, :custom_text2_name, :custom_text3_name,
      :custom_bool1_name, :custom_bool2_name, :custom_bool3_name,
      :custom_date1_name, :custom_date2_name, :custom_date3_name
    )
  end

  def set_custom_field_states(collection)
    collection.custom_string1_state = collection.custom_string1_name.present?
    collection.custom_string2_state = collection.custom_string2_name.present?
    collection.custom_string3_state = collection.custom_string3_name.present?
    collection.custom_int1_state = collection.custom_int1_name.present?
    collection.custom_int2_state = collection.custom_int2_name.present?
    collection.custom_int3_state = collection.custom_int3_name.present?
    collection.custom_text1_state = collection.custom_text1_name.present?
    collection.custom_text2_state = collection.custom_text2_name.present?
    collection.custom_text3_state = collection.custom_text3_name.present?
    collection.custom_bool1_state = collection.custom_bool1_name.present?
    collection.custom_bool2_state = collection.custom_bool2_name.present?
    collection.custom_bool3_state = collection.custom_bool3_name.present?
    collection.custom_date1_state = collection.custom_date1_name.present?
    collection.custom_date2_state = collection.custom_date2_name.present?
    collection.custom_date3_state = collection.custom_date3_name.present?
  end
end
