class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :set_locale

private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def not_authenticated
    redirect_to login_path, alert: t('need_login')
  end
end
