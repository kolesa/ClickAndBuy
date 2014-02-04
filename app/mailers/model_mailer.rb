class ModelMailer < ActionMailer::Base
  default from: "postmaster@sandbox97427.mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.user_add_notification.subject
  #
  def user_add_notification
    @greeting = "Hi"

    mail to: "egokok@gmail.com"
  end
end
