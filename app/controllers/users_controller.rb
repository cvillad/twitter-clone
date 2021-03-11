class UsersController < ApplicationController
  before_action :check_signed_in
  before_action :set_user
  before_action :set_current_user_followings, only: [:follow, :unfollow]

  def show
    @user = User.find_by(username: params[:username])
  end

  def index
    @users = User.where("name like ? or username like ?", "%#{search_param}%", "%#{search_param}%")
  end

  def follow
    @current_user_followings.push(@user)
    flash[:notice] = "Now you are following @#{@user.username}"
    redirect_back(fallback_location: user_path(@user.username)) 
  end

  def unfollow
    @current_user_followings.delete(@user)
    flash[:notice] = "You are no longer following @#{@user.username}"
    redirect_back(fallback_location: user_path(@user.username)) 
  end

  def following
    @users = @user.followings.order(:name).paginate(page: params[:page], per_page: 10)
    render :follows
  end

  def followers 
    @users = @user.followers.order(:name).paginate(page: params[:page], per_page: 10)
    render :follows
  end

  private
  def search_param
    params.require(:search)
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user_followings
    @current_user_followings = current_user.followings
  end
end 
