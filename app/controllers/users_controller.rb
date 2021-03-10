class UsersController < ApplicationController
  layout "follows", only: [:following, :followers]
  before_action :set_user
  before_action :set_current_user_followings, only: [:follow, :unfollow]

  def show
    @user = User.find_by(username: params[:username])
  end

  def follow
    @current_user_followings.push(@user)
    flash[:notice] = "Now you are following @#{@user.username}"
    redirect_to user_path 
  end

  def unfollow
    @current_user_followings.delete(@user)
    flash[:notice] = "You are no longer following @#{@user.username}"
    redirect_to user_path 
  end

  def following
    @users = @user.followings.order(:name).paginate(page: params[:page], per_page: 10)
  end

  def followers 
    @users = @user.followers.order(:name).paginate(page: params[:page], per_page: 10)
  end

  private
  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user_followings
    @current_user_followings = current_user.followings
  end
end 
