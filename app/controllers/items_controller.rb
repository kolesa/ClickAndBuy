class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :like, :tag]
  
  helper_method :sort_column, :sort_direction
  # Tags
  def tagged
    if params[:tag].present? 
      @item = Item.tagged_with(params[:tag]).where(published: true)
    else 
      @item = Item.all.where(published: true)
    end
    render 'static_pages/index'
  end
  

  # GET /items
  # GET /items.json
  def index
    @items = Item.search(params[:item_search]).order("#{sort_column} #{sort_direction}").paginate(:per_page => 5, :page => params[:page])
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
        
        # проверяем, может ли юзер голосовать
        # и что срок акции не закончен
        # и что товар есть в наличии
        if (User.find(current_user).votes.to_i > 0) \
          && (Item.find(@item).count.to_i > 0 || Item.find(@item).count.nil?) \
          && (Item.find(@item).end_date.nil? || Date.parse(Item.find(@item).end_date) <= Date.today)
          
          # уменьшаем кол-во лайков на 1
          User.find(current_user).decrement(:votes).save

          # уменьшаем кол-во товара
          if @item.count.to_i > 0
            @item.decrement(:count).save
          end
          
          
          like = Like.create(user: current_user, item: @item)
          Counter.create(user: current_user, like: like)
        else
          # Нельзя голосовать больше 5 раз в день
          note = 'Likes is over ('
        end

        
      else
        note = 'Item was already liked'
      end
    end
    redirect_to user_info_path(current_user), notice: note
  end

  # DELETE like/:id
  def like_delete
    p params[:id]
    Like.where(id: params[:id]).first.delete
    render nothing: true
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
=begin
  respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
=end
    
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(
        :name,
        :desc,
        :published,
        :price,
        :discount,
        :shop_id,
        :avatar,
        :tag_list,
        :id,
        :end_date,
        :count,
        :sort,
        :direction,
        :item_search)
    end

    def sort_column
      Item.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end  
      
    def sort_direction  
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"   
    end  
end
