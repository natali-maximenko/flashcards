class CardTextValidator < ActiveModel::Validator
  def validate(card)
    if card[:original_text].downcase.strip == card[:translated_text].downcase.strip
      card.errors[:base] << "Original and translated texts must be different"
    end
  end
end

class Card < ApplicationRecord
  validates :original_text, presence: true, length: { minimum: 2 }
  validates :translated_text, presence: true, length: { minimum: 2 }
  validates :review_date, presence: true
  before_create :up_review_date
  validates_with CardTextValidator
  scope :need_review, -> { where('review_date <= ?', Date.today) }
  scope :random, -> { order('RANDOM()') }

  def original_text?(text)
    self.original_text.downcase.strip == text.downcase.strip
  end

  def up_review_date
    self.review_date = Date.today + 3
  end
end
