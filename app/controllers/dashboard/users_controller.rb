class Dashboard::UsersController < Dashboard::ApplicationController
  #skip_before_action :require_login, only: [:index, :new, :create, :current_pack]
  before_action :user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def current_pack
    if current_user.update(current_pack_id: params[:pack_id])
      redirect_to packs_path
    else
      redirect_to(:current)
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :locale)
  end

  def user
    @user = User.find(params[:id])
  end
end
