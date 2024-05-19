# class CollectionsController < ApplicationController
#   before_action :set_collection, only: %i[ show edit update destroy ]
#   before_action :authenticate_user!, except: [:index, :show]
#   before_action :authenticate_admin!, except: [:index, :show]

#   # GET /collections or /collections.json
#   def index
#     @collections = Collection.all
#   end

#   # GET /collections/1 or /collections/1.json
#   def show
#   end

#   def admin_page
#   end

#   # GET /collections/new
#   def new
#     @collection = Collection.new
#   end

#   # GET /collections/1/edit
#   def edit
#   end

#   # POST /collections or /collections.json
#   def create
#     @collection = Collection.new(collection_params)

#     respond_to do |format|
#       if @collection.save
#         format.html { redirect_to collection_url(@collection), notice: "Collection was successfully created." }
#         format.json { render :show, status: :created, location: @collection }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @collection.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /collections/1 or /collections/1.json
#   def update
#     respond_to do |format|
#       if @collection.update(collection_params)
#         format.html { redirect_to collection_url(@collection), notice: "Collection was successfully updated." }
#         format.json { render :show, status: :ok, location: @collection }
#       else
#         format.html { render :edit, status: :unprocessable_entity }
#         format.json { render json: @collection.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /collections/1 or /collections/1.json
#   def destroy
#     @collection.destroy!

#     respond_to do |format|
#       format.html { redirect_to collections_url, notice: "Collection was successfully destroyed." }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_collection
#       @collection = Collection.find(params[:id])
#     end

#     # Only allow a list of trusted parameters through.
#     def collection_params
#       params.require(:collection).permit(:name, :description, :category, :image, :user_id)
#     end
# end

class CollectionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :home]
  before_action :authenticate_admin!, except: [:index, :show, :home]
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

  def home
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
