class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :authenticate_admin!, except: [:show, :edit, :update, :new, :create, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_collection, only: [:index, :new, :create]

  def index
    @items = @collection.items
  end

  def show
    @collection = @item.collection
    @user = @collection.user
    @comments = @item.comments
    @comment = Comment.new
  end

  def new
    @item = @collection.items.build
  end

  def create
    if @collection.user == current_user or current_user.admin?
      @item = @collection.items.build(item_params)
      @item.tag = params[:tag].split(',').map(&:strip) if params[:tag]
      if @item.save
        redirect_to collection_path(@collection), notice: 'Item was successfully created.'
      else
        render :new
      end
    end
  end

  def edit
    @collection = @item.collection
  end

  def update
    if @item.collection.user == current_user or current_user.admin?
      @item.tag = params[:tag].split(',').map(&:strip) if params[:tag]
      if @item.update(item_params)
        redirect_to item_path, notice: 'Item was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    if @item.collection.user == current_user or current_user.admin?
      @item.destroy
      redirect_to collection_path(@item.collection), notice: 'Item was successfully destroyed.'
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:collection_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :custom_string1_value, :custom_string2_value, :custom_string3_value,
                                 :custom_int1_value, :custom_int2_value, :custom_int3_value, :custom_text1_value,
                                 :custom_text2_value, :custom_text3_value, :custom_bool1_value, :custom_bool2_value,
                                 :custom_bool3_value, :custom_date1_value, :custom_date2_value, :custom_date3_value, :tag)
  end

end
