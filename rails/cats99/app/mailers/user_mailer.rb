class UserMailer < ApplicationMailer
  default from: 'barrett@cats99.com'

  def welcome_email(user)
    @user = user
    mail to: "barrettross23@gmail.com", subject: "Welcome to my site"
  end
end
