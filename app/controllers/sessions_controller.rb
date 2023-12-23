class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = User.authenticate_by(email: user_params[:email], password: user_params[:password])
      login(@user)
      redirect_to root_path, notice: "You have successfully logged in."
    else
      @user = User.new
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout(current_user)
    redirect_to root_path, notice: "You have successfully logged out."
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end