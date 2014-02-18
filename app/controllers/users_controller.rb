class UsersController < ApplicationController
  before_action :check_auth, only: [:index]
  before_action :get_user,   only: [:show, :vote]
  before_action :set_item,   only: [:delete, :admin, :ban, :owned, :own]

  # GET /users
  def index
    @users = User.all.order("created_at DESC").paginate(:per_page => 10, :page => params[:page])
  end

  def vote
    if signed_in? && (User.find(current_user).votes.to_i > 0) \
      && !Counter.exists?(user: current_user, like: Like.find(params[:like]))
      
        # уменьшаем кол-во лайков на 1
        User.find(current_user).decrement!(:votes)
        
        Counter.create(user: current_user, like: Like.find(params[:like]))
      
    end
    redirect_to user_info_path(User.find(params[:id]))
  end

  # GET /user/:id
  def show
    @likes = Like.where(user: @user, ended: false)
    @bars = []
    
    @likes.each do |like|
      total = like.counters.count
      
      discounts = like.item.discounts.where(active: true).order("discount ASC")
      width = 100.0/discounts.count

      @bars.push( id: like.id, total: total, discounts: discounts, width: width )
    end
    
    @codes = Like.where(user: @user, ended: true)

  end

  # GET /user/:id/own
  def owned
  end

  # POST /user/:id/own
  def own
    u = User.find(@user.id)
    u.owned_shop = params[:shop]
    u.save
    redirect_to user_owned_path(@user), :notice => 'Owned!'
  end

  # DELETE /user/:id/delete
  def delete
    @user.delete
    redirect_to users_path
  end



  # POST /user/:id/admin
  def admin
    if @user.is_admin
      @user.is_admin = false
    else
      @user.is_admin = true
    end

    @user.save
    redirect_to users_path
  end

  # POST /user/:id/ban
  def ban
    if @user.is_banned
      @user.is_banned = false
    else
      @user.is_banned = true
    end
    
    @user.save
    redirect_to users_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_item
      redirect_to root_path unless signed_in? and current_user.is_admin
      @user = User.find(params[:id])
    end

    def get_user
      @user = User.find(params[:id])
    end

    def check_auth
      redirect_to root_path unless signed_in? and current_user.is_admin
    end
end
