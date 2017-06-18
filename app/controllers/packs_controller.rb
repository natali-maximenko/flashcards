class PacksController < ApplicationController
  before_action :find_pack, only: [:edit, :update, :show, :destroy]

  def index
    @packs = current_user.packs
  end

  def new
    @pack = Pack.new
  end

  def create
    @pack = current_user.packs.build(pack_params)

    if @pack.save
      redirect_to packs_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @pack.update(pack_params)
      redirect_to packs_url
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @pack.destroy

    redirect_to packs_path
  end

  def current
    @current = current_user.current_pack_id
  end

private
  def pack_params
    params.require(:pack).permit(:name)
  end

  def find_pack
    @pack = current_user.packs.find(params[:id])
  end
end
