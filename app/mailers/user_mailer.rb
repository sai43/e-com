class UserMailer < ApplicationMailer

  default :from => "no-reply@e-com.io"

  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to E-com website").deliver_now
  end

end
