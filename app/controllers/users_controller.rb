class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user

    (user_params[:password].blank? && user_params[:password_confirmation].blank?) ? @user.update_without_password(user_params) : @user.update_attributes(user_params)
    flash[:notice]=I18n.t('profile.updated_successfully')
    redirect_to edit_user_path(@user)
  end

  def resend_invite_email
    email = User.find(params[:id]).email
    User.invite!({email: email}, nil, opts = {current_user: current_user.name})
    respond_to do |format|
      format.js { render nothing: true }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email)
  end

end

