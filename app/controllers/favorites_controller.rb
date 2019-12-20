class FavoritesController < ApplicationController
  before_action :forbid_not_login_user
  
  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.favorite(tweet)
    favorite = current_user.favorites.find_by(tweet_id: tweet.id)
    current_user.create_alert_favorite(favorite)
    redirect_back(fallback_location: tweets_path)
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    current_user.quit_favorite(tweet)
    redirect_back(fallback_location: tweets_path)
  end
end
