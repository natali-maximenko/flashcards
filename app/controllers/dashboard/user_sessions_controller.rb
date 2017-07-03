class Dashboard::UserSessionsController < Dashboard::ApplicationController

  def destroy
    logout
    redirect_to(:login, notice: t('.msg'))
  end
end
