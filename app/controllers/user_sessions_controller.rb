class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:root, notice: t('.success'))
    else
      flash.now[:alert] = t('.fail')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:login, notice: t('.msg'))
  end
end
