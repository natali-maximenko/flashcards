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
      successfull
    elsif @card.text_distance(params[:user_text]) == 1
      misprint
    else
      failed
    end
    tutor = SuperMemoTutor.new(card: @card, review_status: @checked,
                       response_time: params[:response_time])
    tutor.review!
    take_card if tutor.correct_status?(@checked)
    respond_to do |format|
      format.js
    end
  end

private
  def successfull
    @msg = t('.success')
    @flash_type = :success
    @checked = SuperMemoTutor::PERFECT_RESPONSE
  end

  def misprint
    @msg = t('.misprint', original_text: @card.original_text, user_text: params[:user_text])
    @flash_type = :warning
    @checked = SuperMemoTutor::CORRECT_RESPONSE
  end

  def failed
    @msg = t('.fail')
    @flash_type = :danger
    @checked = SuperMemoTutor::INCORRECT_RESPONSE
  end

  def take_card
    @next_card = random_card
  end

  def random_card
    current_user.current_pack_id.nil? ? current_user.cards.need_review.random.first
            : current_user.current_pack.cards.need_review.random.first
  end

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
