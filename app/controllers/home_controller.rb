class HomeController < ApplicationController
  def index
    @card = if current_user.current_pack_id.nil?
      current_user.cards.need_review.random.first
    else
      Pack.find(current_user.current_pack_id).cards.need_review.random.first
    end
  end
end
