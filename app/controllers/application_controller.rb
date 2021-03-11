class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  require 'will_paginate/array'
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_signed_in
    redirect_to new_user_session_path if !user_signed_in?
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
