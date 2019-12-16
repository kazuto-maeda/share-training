class ToppagesController < ApplicationController
  
  def index
    if logged_in?
      redirect_to(tweets_path)
    end
  end
  
end
