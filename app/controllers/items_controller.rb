# class ItemsController < ApplicationController
#   before_action :set_item, only: %i[ show edit update destroy ]

#   # GET /items or /items.json
#   def index
#     @items = Item.all
#   end

#   # GET /items/1 or /items/1.json
#   def show
#   end

#   # GET /items/new
#   def new
#     @item = Item.new
#   end

#   # GET /items/1/edit
#   def edit
#   end

#   # POST /items or /items.json
#   def create
#     @item = Item.new(item_params)

#     respond_to do |format|
#       if @item.save
#         format.html { redirect_to item_url(@item), notice: "Item was successfully created." }
#         format.json { render :show, status: :created, location: @item }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @item.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /items/1 or /items/1.json
#   def update
#     respond_to do |format|
#       if @item.update(item_params)
#         format.html { redirect_to item_url(@item), notice: "Item was successfully updated." }
#         format.json { render :show, status: :ok, location: @item }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @item.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /items/1 or /items/1.json
#   def destroy
#     @item.destroy!

#     respond_to do |format|
#       format.html { redirect_to items_url, notice: "Item was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_item
#       @item = Item.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def item_params
#       params.require(:item).permit(:name, :tags, :author, :collection_id)
#     end
# end

class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!
  before_action :set_collection
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = @collection.items
  end

  def show
    @comments = @item.comments
  end

  def new
    @item = @collection.items.build
  end

  def create
    @item = @collection.items.build(item_params)
    if @item.save
      redirect_to [@collection, @item], notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to [@collection, @item], notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to collection_items_url(@collection), notice: 'Item was successfully destroyed.'
  end

  private

  def set_collection
    @collection = current_user.collections.find(params[:collection_id])
  end

  def set_item
    @item = @collection.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :tags, :custom_string1_value, :custom_string2_value, :custom_string3_value, :custom_int1_value, :custom_int2_value, :custom_int3_value, :custom_text1_value, :custom_text2_value, :custom_text3_value, :custom_bool1_value, :custom_bool2_value, :custom_bool3_value, :custom_date1_value, :custom_date2_value, :custom_date3_value)
  end
end
