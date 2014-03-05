class ModelMailer < ActionMailer::Base
  #default from: "postmaster@sandbox97427.mailgun.org"
  default from: "support@likeandbuy.me"

  #support@likeandbuy.me:48QWQ84CJxGcQ

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.user_add_notification.subject
  #
  def support(shop, user, text)
    @shop = shop
    @user = user
    @text = text
    mail    to: "egokok@gmail.com", subject: "Новый вопрос от #{@shop.name}"
    
  end
end
