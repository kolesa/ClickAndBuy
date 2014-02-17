class ModelMailer < ActionMailer::Base
  #default from: "postmaster@sandbox97427.mailgun.org"
  default from: "support@likeandbuy.me"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.user_add_notification.subject
  #
  def support(shop, user, text)
    @shop = shop
    @user = user
    @text = text
    mail    to: "egokok@gmail.com", cc: 'vishma@mail.ru', bcc: 'antonary@mail.ru', subject: "Новый вопрос от #{@shop.name}"
    
  end
end
