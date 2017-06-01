class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_url
    else
      render 'new'
    end
  end

private
  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date)
  end

end
