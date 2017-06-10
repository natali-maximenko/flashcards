class CardsController < ApplicationController
  before_action :find_card, only: [:edit, :update, :show, :destroy, :check]

  def index
    @cards = current_user.cards
  end

  def new
    @card = Card.new
  end

  def create
    @card = current_user.cards.build(card_params)

    if @card.save
      redirect_to cards_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @card.update(card_params)
      redirect_to cards_url
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @card.destroy

    redirect_to cards_path
  end

  def check
    if @card.original_text?(params[:user_text])
      flash[:success] = 'Верно! Продолжай.'
      @card.up_review_date
      @card.save
    else
      flash[:danger] = 'Ошибочка вышла, попробуй ещё раз.'
    end
    redirect_to root_path
  end

private
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

  def find_card
    @card = current_user.cards.find(params[:id])
  end
end
