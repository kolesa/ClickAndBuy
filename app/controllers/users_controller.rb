class UsersController < ApplicationController
  before_action :set_item, only: [:show]

  def profile
    @user  = current_user
    @likes = Like.where(user: current_user)
  end

  def index
    @users  = User.all
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @user = User.find(params[:id])
    end
end
