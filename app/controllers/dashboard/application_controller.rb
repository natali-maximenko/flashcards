class Dashboard::ApplicationController < ApplicationController
  before_action :require_login

private

  def locale
    if current_user
      current_user.locale
    elsif session[:locale]
      session[:locale]
    end
  end

  def not_authenticated
    redirect_to login_path, alert: t('need_login')
  end
end
