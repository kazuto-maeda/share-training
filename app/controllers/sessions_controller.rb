class SessionsController < ApplicationController
  before_action :forbid_not_login_user, only: [:destroy]
  before_action :forbid_login_user, only: [:new, :create]
  
  def new
  end 
  
  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      flash[:success] = "ログインしました"
      redirect_to(root_url)
    else
      flash[:danger] = "ログインに失敗しました"
      @error_message = "メールアドレスかパスワードが間違っています"
      render(:new)
    end 
  end 
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to(login_path)
  end 
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end 
  
end
