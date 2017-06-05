class HomeController < ApplicationController
  def index
    @card = Card.need_review.random.first
  end
end
