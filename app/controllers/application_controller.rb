class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def forbid_login_user
    if logged_in?
      flash[:danger] = "すでにログインしています"
     redirect_to(tweets_path)
    end 
  end 
  
  def forbid_not_login_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to(login_path)
    end
  end 
  
  def count(user)
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorite_tweets.count
  end
  
  def alert_inform
    @count_alerts = Alert.where("(alerted = ?) AND (user_id != ?) AND (checked = ?)",current_user.id, current_user, 0).count
  end
  
end
