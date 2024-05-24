class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_admin!, except: [:show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_collection, only: [:index, :new, :create]

  def index
    @items = @collection.items
  end

  def show
    @comments = @item.comments
    @comment = Comment.new
  end

  def new
    @item = @collection.items.build
  end

  def create
    @item = @collection.items.build(item_params)
    if @item.save
      redirect_to collection_item_path(@collection, @item), notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to collection_item_path(@collection, @item), notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to collection_path(@item.collection), notice: 'Item was successfully destroyed.'
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :tag, :custom_string1_value, :custom_string2_value, :custom_string3_value,
                                 :custom_int1_value, :custom_int2_value, :custom_int3_value, :custom_text1_value,
                                 :custom_text2_value, :custom_text3_value, :custom_bool1_value, :custom_bool2_value,
                                 :custom_bool3_value, :custom_date1_value, :custom_date2_value, :custom_date3_value)
  end

end
