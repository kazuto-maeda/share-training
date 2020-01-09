class PasswordsController < ApplicationController
  before_action :forbid_not_login_user

  def show
    redirect_to(edit_password_path)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    current_password = params[:user][:current_password]

    if current_user.email = "guest@guest.guest"
      flash[:danger] = "ゲストユーザーのパスワードは変更できません"
      redirect_to(current_user)
    else
      if current_password.present?
        if @user&.authenticate(current_password)
          if @user.update(password_params)
            flash[:success] = "パスワードを更新しました"
            redirect_to(@user)
          else
            flash[:danger] = "パスワードの更新に失敗しました"
            render(:edit)
          end
        else
          flash[:danger] = "パスワードの更新に失敗しました"
          @user.errors.add(:current_password, :wrong)
          render(:edit)
        end
      else
        flash[:danger] = "パスワードの更新に失敗しました"
        @user.errors.add(:current_password, :empty)
        render(:edit)
      end
    end
  end

  private

  def password_params
   params.require(:user).permit(:current_password, :password, :password_confirmation)
 end
end
