class UserCollectionsController < ApplicationController
  before_action :set_user_collection, only: %i[ show edit update destroy ]

  # GET /user_collections or /user_collections.json
  def index
    @user_collections = UserCollection.all
  end

  # GET /user_collections/1 or /user_collections/1.json
  def show
  end

  # GET /user_collections/new
  def new
    @user_collection = UserCollection.new
  end

  # GET /user_collections/1/edit
  def edit
  end

  # POST /user_collections or /user_collections.json
  def create
    @user_collection = UserCollection.new(user_collection_params)

    respond_to do |format|
      if @user_collection.save
        format.html { redirect_to user_collection_url(@user_collection), notice: "User collection was successfully created." }
        format.json { render :show, status: :created, location: @user_collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_collections/1 or /user_collections/1.json
  def update
    respond_to do |format|
      if @user_collection.update(user_collection_params)
        format.html { redirect_to user_collection_url(@user_collection), notice: "User collection was successfully updated." }
        format.json { render :show, status: :ok, location: @user_collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_collections/1 or /user_collections/1.json
  def destroy
    @user_collection.destroy!

    respond_to do |format|
      format.html { redirect_to user_collections_url, notice: "User collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_collection
      @user_collection = UserCollection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_collection_params
      params.require(:user_collection).permit(:user_id, :collection_id)
    end
end
