class Home::UserSessionsController < Home::ApplicationController

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(:review, notice: t('.success'))
    else
      flash.now[:alert] = t('.fail')
      render action: 'new'
    end
  end
end
