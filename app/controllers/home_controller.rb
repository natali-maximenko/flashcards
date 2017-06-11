class HomeController < ApplicationController
  def index
    @card = current_user.cards.need_review.random.first
  end
end
