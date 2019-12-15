class TweetsController < ApplicationController
  before_action :forbid_not_login_user
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_to_tweet, only: [:edit, :update, :destroy]
  
  def followings
    @tweets = current_user.feed_microposts
  end 
  
  def index
    @tweets = Tweet.all
  end 
  
  def show
    @trainings = @tweet.trainings.all
  end 
  
  def new
    @tweet = current_user.tweets.build
    @menu = @tweet.trainings.build
  end 
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "投稿を作成しました"
      redirect_to(root_url)
    else
      flash[:danger] = "投稿の作成に失敗しました"
      render(:new)
    end 
    
  end 
  
  def edit
  end 
  
  def update
    if @tweet.update(tweet_params)
      flash[:success] = "投稿を編集しました"
      redirect_to(root_url)
    else
      flash[:danger] = "投稿の編集に失敗しました"
      render(:edit)
    end
  end 
  
  def destroy
    @tweet.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to(root_url)
  end 
  
  private
  
  def tweet_params
    params.require(:tweet).permit(:content, :image, trainings_attributes: [:id, :menu, :weight, :count, :set, :_destroy])
  end 
  
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  def correct_user_to_tweet
    if current_user != @tweet.user
      flash[:danger] = "権限がありません"
      redirect_to(root_url)
    end
  end
end
