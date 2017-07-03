class Home::ApplicationController < ApplicationController

private

  def locale
    if params[:locale]
      params[:locale]
    elsif session[:locale]
      session[:locale]
    else
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end
end
