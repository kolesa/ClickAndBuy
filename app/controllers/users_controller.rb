class UsersController < ApplicationController
  before_action :index_item, only: [:index]
  before_action :get_user,   only: [:show, :vote]
  before_action :set_item,   only: [:delete, :admin, :ban]


  def autocomplete_user_last_name
    users = User.where("last_name LIKE ?" , "%#{params[:last_name]}%")
    render json: users.map { |x| [x.id, x.last_name]}
  end

  # GET /users
  def index
  end

  def vote
    unless Counter.exists?(user: current_user, like: Like.find(params[:like]))
      Counter.create(user: current_user, like: Like.find(params[:like]))
      #Array(User.pluck(:id)).map{|x| Counter.create(user_id: x, like: Like.find( Like.where(user_id: 1).pluck(:id).shuffle.first)) }

    end
    redirect_to user_info_path(User.find(params[:id]))
  end

  # GET /user/:id
  def show
    @likes = Like.where(user: @user)
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

    def index_item
      redirect_to root_path unless signed_in? and current_user.is_admin
      @users = User.all
    end
end
