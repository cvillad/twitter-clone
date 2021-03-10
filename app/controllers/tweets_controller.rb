class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.reverse.paginate(page: params[:page], per_page: 10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      flash[:notice]="Tweet posted succesfully"
      redirect_to tweets_path
    else
      render :new
    end
  end

  def destroy
    @tweet = current_user.tweets.find(params[:id])
    @tweet.destroy
    flash[:notice] = "Tweet deleted successfully"
    redirect_to tweets_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end

end
