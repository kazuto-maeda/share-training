class CommentsController < ApplicationController
  before_action :forbid_not_login_user
  
  def index
    redirect_to(tweets_url)
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    @comment.tweet_id = params[:tweet_id]
    @tweet = Tweet.find(@comment.tweet_id)
    @user = @tweet.user
    if @comment.save
      flash[:success] = "コメントを投稿しました"
      if current_user.id != @tweet.user.id
        @user.alerts.create(comment_id: @comment.id)
      end
      redirect_to(@tweet)
    else
      flash[:danger] = "コメントの投稿に失敗しました"
      @trainings = @tweet.trainings.all
      @comments = @tweet.comments.all
      render "tweets/show"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @tweet = Tweet.find(@comment.tweet_id)
    if @comment.user_id == current_user.id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
      redirect_to(@tweet)
    else
      flash[:danger] = "権限がありません"
      redirect_to(@tweet)
    end 
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end 
  
end
