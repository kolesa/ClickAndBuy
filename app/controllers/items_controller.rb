class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :like, :tag]
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @rand = Item.order('RANDOM()').limit(3)
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # POST /items/1/edit
  def edit
  end

  # GET /items/1/like
  def like
    #like = Like.new(user: current_user, item: @item)
    note = 'Sign In first!'
    if signed_in?
      note = 'Item was liked.'
      unless Like.exists?(user: current_user, item: @item)
        like = Like.create(user: current_user, item: @item)
        Counter.create(user: current_user, like: like)
      else
        note = 'Item was already liked'
      end
    end
    redirect_to @item, notice: note
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    p item_params
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end

  # Tags
  def tagged
    if params[:tag].present? 
      @item = Item.tagged_with(params[:tag])
    else 
      @item = Item.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :desc, :published, :price, :discount, :shop_id, :avatar, :tag_list)
    end
end
