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
    @count_unread_alert = current_user.alerts.where("(checked = ?)", "unread").count
  end

end
