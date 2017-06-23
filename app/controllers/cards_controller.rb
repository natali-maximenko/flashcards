class CardsController < ApplicationController
  before_action :find_pack, only: [:new, :create, :edit, :update, :show, :destroy, :index]
  before_action :find_card, only: [:edit, :update, :show, :destroy, :check]

  def index
    @cards = @pack.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = @pack.cards.build(card_params)

    if @card.save
      redirect_to pack_cards_url(@pack)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to pack_cards_url(@pack)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @card.destroy

    redirect_to pack_cards_url(@pack)
  end

  def check
    if @card.original_text?(params[:user_text])
      flash[:success] = t('.success')
      checked = SuperMemoTutor::PERFECT_RESPONSE
    elsif @card.text_distance(params[:user_text]) == 1
      flash[:warning] = t('.misprint', original_text: @card.original_text, user_text: params[:user_text])
      checked = SuperMemoTutor::CORRECT_RESPONSE
    else
      flash[:danger] = t('.fail')
      checked = SuperMemoTutor::INCORRECT_RESPONSE
    end
    SuperMemoTutor.new(@card, checked, params[:response_time]).recalculate
    redirect_to root_path
  end

private
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date, :picture)
  end

  def find_card
    @card = Card.find(params[:id])
  end

  def find_pack
    @pack = current_user.packs.find(params[:pack_id])
  end
end
