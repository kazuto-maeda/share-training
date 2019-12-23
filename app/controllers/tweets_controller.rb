class TweetsController < ApplicationController
  before_action :forbid_not_login_user
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :correct_user_to_tweet, only: [:edit, :update, :destroy]
  before_action :alert_inform

  def followings
    @tweets = current_user.feed_tweets.order(id: :desc).page(params[:page]).per(6)
  end 
  
  def index
    @tweets = Tweet.order(id: :desc).page(params[:page]).per(6)
  end 
  
  def show
    @user = @tweet.user
    @trainings = @tweet.trainings.where.not(menu: [nil,""])
    @comment = current_user.comments.build
    @comments = @tweet.comments.order(id: :desc)
  end 
  
  def new
    @tweet = current_user.tweets.build
    @menu = @tweet.trainings.build
  end 
  
  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      flash[:success] = "投稿を作成しました"
      redirect_to(tweets_path)
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
      redirect_to(tweets_path)
    else
      flash[:danger] = "投稿の編集に失敗しました"
      render(:edit)
    end
  end 
  
  def destroy
    @tweet.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to(tweets_path)
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
      redirect_to(tweets_path)
    end
  end
end
