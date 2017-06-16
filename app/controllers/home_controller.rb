class HomeController < ApplicationController
  def index
    if current_user.packs.current.empty?
      @card = current_user.cards.need_review.random.first
    else
      @card = current_user.packs.current.first.cards.need_review.random.first
    end
  end
end
