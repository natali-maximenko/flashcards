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
    @current = Pack.current.empty? ? '' : Pack.current.first.id
  end

  def set_current
    current_pack = Pack.current.empty? ? nil : Pack.current.first
    pack = Pack.find(params[:pack_id])
    if current_pack && pack.id != current_pack.id
      current_pack.current = false
      current_pack.save
      pack.current = true
      pack.save
    elsif current_pack.nil? && pack
      pack.current = true
      pack.save
    end
    redirect_to packs_path
  end

private
  def pack_params
    params.require(:pack).permit(:name)
  end

  def find_pack
    @pack = current_user.packs.find(params[:id])
  end
end
