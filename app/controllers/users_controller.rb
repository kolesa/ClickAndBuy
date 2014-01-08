class UsersController < ApplicationController
  def profile
    @user  = current_user
    @likes = Like.where(user: current_user)
  end
end
