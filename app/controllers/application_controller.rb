class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  def forbid_login_user
    if logged_in?
      flash[:danger] = "すでにログインしています"
     redirect_to(root_url)
    end 
  end 
  
  def forbid_not_login_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to(login_path)
    end
  end 
end
