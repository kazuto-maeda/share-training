class RelationshipsController < ApplicationController
  before_action :forbid_not_login_user
  
  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    relationship = current_user.relationships.find_by(follow_id: user.id)
    current_user.create_alert_follow(relationship)
    flash[:success] = "ユーザをフォローしました"
    redirect_back(fallback_location: tweets_path)
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    flash[:success] = "ユーザのフォローを解除しました"
    redirect_back(fallback_location: tweets_path)
  end
end
