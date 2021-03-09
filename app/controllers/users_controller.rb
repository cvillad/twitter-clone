class UsersController < ApplicationController
  before_action :set_user

  def show
    @user = User.find_by(username: params[:username])
  end

  def follow
    current_user.followings.push(@user)
    redirect_to user_path 
  end

  def unfollow
    current_user.followings.delete(@user)
    redirect_to user_path 
  end

  def following
    @users = @user.followings
  end

  def followers 
    @users = @user.followers
  end

  private
  def set_user
    @user = User.find_by(username: params[:username])
  end

end 
