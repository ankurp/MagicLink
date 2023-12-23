class PasswordMailer < ApplicationMailer
  def password_reset
    mail to: params[:user].email, subject: "Password Reset"
  end
end
