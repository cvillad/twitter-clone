class UsersController < ApplicationController
  before_action :check_signed_in
  before_action :set_user

  def show
    @user = User.find_by(username: params[:username])
    @tweets = @user.tweets.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def index
    @users = User.where("lower(name) like ? or lower(username) like ?", "%#{search_param.downcase}%", "%#{search_param.downcase}%").paginate(page: params[:page], per_page: 10)
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
    params[:search]
  end

  def set_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user_followings
    @current_user_followings = current_user.followings
  end
end 
