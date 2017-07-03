class Home::UsersController < Home::ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to @user
    else
      render :new
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end
end
