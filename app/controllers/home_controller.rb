class HomeController < ApplicationController
  layout "home"

  def index
    redirect_to tweets_path if user_signed_in?
  end
end