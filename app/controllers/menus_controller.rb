class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.scoped.arrange(:order => :position)
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    p "parent -> #{params[:parent_id]}"
    @menu = Menu.new(parent_id: params[:parent_id])
  end

  # GET /menus/1/edit
  def edit
  end

  # POST /menus
  # POST /menus.json
  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  def update
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end

  def sort
    #p "RECV #{params[:menu]}"
    
    params[:menu].sort { |a, b| a <=> b }.each_with_index do |id, index|
            
      menu = id[1][:id]
      position = id[1][:position].to_i + 1
      id[1][:parent_id] == 'null' ? parent = nil : parent = id[1][:parent_id]

      p "-> #{index} | #{menu} <- #{parent} : #{position}"
      
      Menu.find(menu).update(:position => position, :parent_id => parent)
    end
    render :nothing => true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:name, :parent_id)
    end
end
