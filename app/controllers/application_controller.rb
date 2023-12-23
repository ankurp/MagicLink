class ApplicationController < ActionController::Base
  before_action :set_current_user

  private

  helper_method :user_signed_in?, :current_user

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  def set_current_user
    current_user
  end

  def current_user
    Current.user ||= User.find_by(id: session[:user_id])
  end

  def login(user)
    reset_session
    session[:user_id] = user.id
    Current.user = user
  end

  def logout(user)
    reset_session
    session[:user_id] = nil
  end
end
