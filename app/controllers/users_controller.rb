class UsersController < ApplicationController
  before_action :forbid_login_user, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :followings, :followers, :likes, :edit_profile, :update_profile, :destroy_image]
  before_action :forbid_not_login_user, only: [:index, :show, :edit, :update, :destoy, :followings, :followers, :likes, :edit_profile, :update_profile, :destroy_image]
  before_action :correct_user, only: [:edit, :update, :edit_profile, :update_profile, :destroy_image]
  before_action :alert_inform, only: [:inex, :show, :edit, :update, :followings, :followers, :likes, :edit_profile, :update_profile, :destroy_image]

  def index
    @users = User.order(id: :desc).page(params[:page])
  end 
  
  def new
    @user = User.new
  end 
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーの登録が完了しました"
      session[:user_id] = @user.id
      redirect_to(@user)
    else
      flash[:danger] = "ユーザーの登録に失敗しました"
      render(:new)
    end
  end 
  
  def show
    @tweets = @user.tweets.order(id: :desc).page(params[:page]).per(6)
    count(@user)
  end 
  
  def edit
  end 
  
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to(user_path)
    else
      flash[:danger] = "ユーザー情報の編集に失敗しました"
      render(:edit)
    end
  end 
  
  def destroy
    current_user.destroy
    flash[:success] = "ユーザー情報を削除しました"
    redirect_to(signup_path)
  end 
  
  def destroy_image
    @user.remove_image!
    @user.save
    redirect_to(@user)
  end
  
  def followings
    @followings = @user.followings.order(id: :desc).page(params[:page])
    count(@user)
  end 
  
  def followers
    @followers = @user.followers.order(id: :desc).page(params[:page])
    count(@user)
  end 
  
  def likes
    @likes = @user.favorite_tweets.order(id: :desc).page(params[:page]).per(6)
    count(@user)
  end
  
  def edit_profile
  end 
  
  def update_profile
    if @user.update(profile_params)
      flash[:success] = "プロフィール情報を編集しました"
      redirect_to(user_url)
    else
      flash[:danger] = "プロフィール情報の編集に失敗しました"
      render(:edit_profile)
    end
  end 
  
 private
 
 def user_params
   params.require(:user).permit(:name, :email)
 end
 
 def profile_params
   params.require(:user).permit(:image, :profile, :training_years, :age, :weight, :sex)
 end
 
 def set_user
   @user = User.find(params[:id])
 end 
 
 def correct_user
   if @user != @current_user
     flash[:danger] = "権限がありません"
     redirect_to(users_url)
   end
 end
end
