class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def vkontakte
    @user = User.find_for_vkontakte_oauth request.env["omniauth.auth"]

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte"
    else
      flash[:notice] = "authentication error"
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth request.env["omniauth.auth"]

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
    else
      flash[:notice] = "authentication error"
      redirect_to new_user_registration_url
    end
  end

  def odnoklassniki
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "odnoklassniki"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end