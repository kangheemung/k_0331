class UserMailer < ApplicationMailer
  #default from: 'kurotamashi20@gmail.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #def account_activation(user)
      #@user = User.all
      #UserMailer.account_activation(@user)
      
  #end

  def account_activation(user)
    @greeting = "Hi"
    @username = user.username
    mail to: user.email, subject: "ようこそ！！"
  end

  #   en.user_mailer.user_created.subject
  #
  def password_reset(user)
    @greeting = "Hi"
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
