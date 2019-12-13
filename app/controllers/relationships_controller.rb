class RelationshipsController < ApplicationController
  before_action :forbid_not_login_user
  
  def create
    @user = User.find_by(id: params[:follow_id])
    current_user.follow(@user)
    flash[:success] = "フォローしました"
    redirect_to(@user)
  end

  def destroy
    @user = User.find_by(id: params[:follow_id])
    current_user.unfollow(@user)
    flash[:success] = "フォローを解除しました"
    redirect_to(@user)
  end
end
