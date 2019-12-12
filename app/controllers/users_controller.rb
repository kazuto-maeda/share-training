class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :forbid_not_login_user, only: [:index, :show, :edit, :update, :destoy]
  
  def index
    @users = User.all
  end 
  
  def new
    @user = User.new
  end 
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザーの登録が完了しました"
      redirect_to(@user)
    else
      flash[:danger] = "ユーザーの登録に失敗しました"
      render(:new)
    end
  end 
  
  def show
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
    @user.destroy
    flash[:success] = "ユーザー情報を削除しました"
    redirect_to(signup_path)
  end 

 private
 
 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end
 
 def set_user
   @user = User.find(params[:id])
 end 
end
