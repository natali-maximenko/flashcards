class HomeController < ApplicationController
  def index
    @card = nil#current_user.cards.need_review.random.first
  end
end
