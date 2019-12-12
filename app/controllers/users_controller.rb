class UsersController < ApplicationController
  
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
    @user = User.find(params[:id])
  end 
  
  def edit
    @user = User.find(params[:id])
  end 
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を編集しました"
      redirect_to(users_path)
    else
      flash[:danger] = "ユーザー情報の編集に失敗しました"
      render(:edit)
    end
  end 
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザー情報を削除しました"
    redirect_to(users_path)
  end 

 private
 
 def user_params
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end
end
