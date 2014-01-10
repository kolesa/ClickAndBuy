class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    #devise_parameter_sanitizer.for(:sign_up) << :full_name
    #devise_parameter_sanitizer.for(:account_update) << :full_name
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :avatar, :email, :password, :password_confirmation,:country, :gender, :date, :vk, :fb, :tw, :od)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:first_name, :last_name, :avatar, :password, :password_confirmation, :current_password, :country, :gender, :date, :vk, :fb, :tw, :od)
    end
  end
end
