class Users::FollowsController < ApplicationController
  before_action :check_signed_in
  before_action :set_user
  before_action :set_current_user_followings, only: [:index, :create, :destroy]
  before_action :param, only: :index

  def index
    if param=="following"
      @users = @user.followings.order(:name).paginate(page: params[:page], per_page: 10)
    else
      @users = @user.followers.order(:name).paginate(page: params[:page], per_page: 10)
    end
  end

  def create
    @current_user_followings.push(@user)
    flash[:notice] = "Now you are following @#{@user.username}"
    redirect_back(fallback_location: user_path(@user.username)) 
  end

  def destroy
    @current_user_followings.destroy(@user)
    flash[:notice] = "You are no longer following @#{@user.username}"
    redirect_back(fallback_location: user_path(@user.username)) 
  end

  private

  def param
    params[:follow]
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user_followings
    @current_user_followings = current_user.followings
  end

end