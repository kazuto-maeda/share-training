class UsersController < ApplicationController
  
  def index
  end 
  
  def new
    @user = User.new
  end 
  
  def create
    @user = User.new(params_user)
    if @user.save
      redirect_to(root_url)
    else
      render(:new)
    end
  end 
  
  def show
  end 
  
  def edit
  end 
  
  def update
  end 
  
  def destroy
  end 

 private
 
 def params_user
   params.require(:user).permit(:name, :email, :password, :password_confirmation)
 end
end
