class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  # e.g
  # def account_activation
  #   @greeting = "Hi"
  #
  #   mail to: "to@example.org"
  # end

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, suject: "Password reset"
    # @greeting = "Hi"
    #
    # mail to: "to@example.org"
  end

  def add_follower(user, follower)
    @user = user
    @follower = follower
    mail to: user.email, suject: "フォロワーの通知"
  end
end
