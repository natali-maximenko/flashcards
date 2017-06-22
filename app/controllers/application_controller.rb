class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :set_locale

private

  def set_locale
    session[:locale] = locale.to_sym if locale && I18n.available_locales.include?(locale.to_sym)
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def locale
    if current_user
      current_user.locale
    elsif params[:locale]
      params[:locale]
    elsif session[:locale]
      session[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

  def not_authenticated
    redirect_to login_path, alert: t('need_login')
  end
end
