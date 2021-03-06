class TweetsController < ApplicationController
  before_action :check_signed_in
  before_action :set_tweets

  def index
    current_user.followings.each do |user|
      @tweets.or!(user.tweets.includes(:user))
    end
    @tweets = @tweets.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    @tweet = Tweet.new
  end

  def create
    @tweet = @tweets.new(tweet_params)
    if @tweet.save
      flash[:notice]="Tweet posted succesfully"
      redirect_to tweets_path
    else
      flash[:alert] = @tweet.errors.full_messages[0]
      redirect_to tweets_path
    end
  end

  def destroy
    @tweet = @tweets.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Tweet deleted successfully"
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweets
    @tweets = current_user.tweets.includes(:user)
  end

end
