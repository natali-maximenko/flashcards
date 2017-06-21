class HomeController < ApplicationController
  def index
    @card = current_user.current_pack_id.nil? ? current_user.cards.need_review.random.first
            : current_user.current_pack.cards.need_review.random.first
  end
end
