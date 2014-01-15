class UsersController < ApplicationController
  before_action :index_item, only: [:index]
  before_action :set_item,   only: [:delete, :admin, :ban]

  # GET /users
  def index

  end

  # GET /user
  def profile
    @user  = current_user
    @likes = Like.where(user: current_user)
  end

  # GET /user/:id
  def show
    @user = User.find(params[:id])
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

    def index_item
      redirect_to root_path unless signed_in? and current_user.is_admin
      @users = User.all
    end
end
