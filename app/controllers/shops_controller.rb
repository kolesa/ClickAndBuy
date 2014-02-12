class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy, :add_item, :items, :stat, :search, :codes, :ban]
  before_action :check_auth, only: [:index, :ban, :create, :destroy, :edit]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @items = @shop.items.load

    if params[:ids]
      @items = @shop.items.where(id: params[:ids])
      render '_item', {items: @items, layout: false}
    end
  end

  # POST /shop/:id/ban
  def ban
    if @shop.blocked
      @shop.blocked = false
    else
      @shop.blocked = true
    end
    
    @shop.save
    redirect_to shops_path
  end

  # GET /shops/new
  def new
    @shop = Shop.new
  end

  def codes
    @codes = Code.where(item_id: @shop.items.pluck(:id))  
  end

  # GET /shops/1/search
  def search
    result = Item.where("lower(name) LIKE lower(?)", "%#{params[:search].downcase}%").where(shop: @shop)
    render json: result
  end

  # GET /shop/:id/:item/statistics
  def stat
    @items = Item.where(id: params[:item])
    @likes = Counter.where( like_id: Like.where(item_id: @items.pluck(:id)) ).count
    @users = Like.where(item_id: @items)
  end

  # GET /shops/1/edit
  def edit
  end

  # GET /shops/1/items
  def items
    @item = Item.new
  end

  # POST /shops/1/items
  def add_items
    @item = @shop.Item.new(item_params)
    if @item.save
      format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
      format.json { render action: 'show', status: :created, location: @shop }
    else
      format.html { render action: 'new' }
      format.json { render json: @shop.errors, status: :unprocessable_entity }
    end
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = Shop.new(shop_params)

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render action: 'show', status: :created, location: @shop }
      else
        format.html { render action: 'new' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shops/1
  # PATCH/PUT /shops/1.json
  def update
    respond_to do |format|
      if @shop.update(shop_params)
        format.html { redirect_to @shop, notice: 'Shop was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    @shop.destroy
    respond_to do |format|
      format.html { redirect_to shops_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find(params[:id])
    end

    def check_auth
      redirect_to root_path unless signed_in? && current_user.is_admin
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :desc, :url, :fb, :vk, :avatar)
    end

    def item_params
      params.require(:item).permit(:name, :desc, :published, :price, :discount, :shop_id, :avatar, :ids, :item)
    end
end
