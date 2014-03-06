class ShopsController < ApplicationController
  before_action :set_shop, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :add_item,
    :support,
    :users,
    :history,
    :items,
    :stat,
    :search,
    :codes,
    :ban
  ]
  
  before_action :check_auth, only: [
    :index,
    :ban,
    :create,
    :destroy,
    :edit,
    :users,
    :stat,
    :codes,
    :support
  ]

  # GET /shops
  # GET /shops.json
  def index
    @shops = Shop.all.paginate(:per_page => 5, :page => params[:page])
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    if signed_in? && ( current_user.owned_shop > 0 || current_user.is_admin ) 
      @items = @shop.items.order('created_at DESC').paginate(:per_page => 20, :page => params[:page])
    else
      @items = @shop.items.where('published = true and end_date >= ?', Date.today).order('created_at DESC').paginate(:per_page => 20, :page => params[:page])
    end
  end

  # GET /shop/:id/users
  def users
    @users = Like.where(item_id: @shop.items.pluck(:id)).paginate(:per_page => 20, :page => params[:page])
  end

  # GET /shop/:id/history
  def history
    @items = Item.where(shop: @shop)..items.where('published = true and end_date >= ?', Date.today).order('created_at DESC').paginate(:per_page => 20, :page => params[:page])
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

  # GET /shop/:id/codes
  def codes
    @codes = Code.where(item_id: @shop.items.pluck(:id))
  end

  # GET /shop/:id/support
  def support
    p "#{@shop.name} #{params[:text]}"

    ModelMailer.support(@shop, current_user, params[:text]).deliver
    redirect_to @shop, :notice => "Письмо отправленно, спасибо за обращение."
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
    p 'new'
    5.times { 
      p 's'
      @item.discounts.build
    }
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
    def not_found
      render 'error/404'
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_shop
      @shop = Shop.find_by_id(params[:id]) || not_found
    end

    def check_auth
      redirect_to root_path unless signed_in? && ( current_user.owned_shop > 0 || current_user.is_admin )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shop_params
      params.require(:shop).permit(:name, :desc, :url, :fb, :vk, :avatar, :p_type, :text)
    end

    def item_params
      params.require(:item).permit(:name, :desc, :published, :price, :discount, :shop_id, :avatar, :item, :text)
    end
end
