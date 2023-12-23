class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    if user = User.find_by(email: user_params[:email])
      PasswordMailer
        .with(user: user, token: user.generate_token_for(:password_reset))
        .password_reset
        .deliver_later
    end
    redirect_to new_password_reset_path, notice: "We have sent you an email with instructions to reset your password."
  end

  def edit
  end

  def update
    if @user.update(password_params)
      redirect_to root_path, notice: "Your password has been reset! Please login."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def password_params
    params
      .require(:user)
      .permit(:password, :password_confirmation)
  end

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, notice: "Invalid or expired token, please try again." unless @user
  end
end