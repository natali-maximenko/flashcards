class CardTextValidator < ActiveModel::Validator
  def validate(card)
    if card[:original_text].downcase.strip == card[:translated_text].downcase.strip
      card.errors[:base] << "Original and translated texts must be different"
    end
  end
end

class Card < ApplicationRecord
  validates :original_text, presence: true, length: { minimum: 3 }
  validates :translated_text, presence: true, length: { minimum: 3 }
  validates :review_date, presence: true
  before_create :set_review_date
  validates_with CardTextValidator

private
  def set_review_date
    self.review_date = Date.today + 3
  end
end
