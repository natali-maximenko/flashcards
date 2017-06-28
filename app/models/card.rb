class CardTextValidator < ActiveModel::Validator
  def validate(card)
    if card[:original_text].downcase.strip == card[:translated_text].downcase.strip
      card.errors[:base] << "Original and translated texts must be different"
    end
  end
end

class Card < ApplicationRecord
  REVIEW_FAILS_LIMIT = 3
  REVIEW_INTERVALS = [ 0, 12.hours, 3.days, 7.days, 2.week, 1.months ]

  validates :original_text, presence: true, length: { minimum: 2 }
  validates :translated_text, presence: true, length: { minimum: 2 }
  before_create :set_review_date
  validates_with CardTextValidator
  scope :need_review, -> { where('review_date <= ?', Time.now) }
  scope :random, -> { order('RANDOM()') }

  belongs_to :pack

  has_attached_file :picture, styles: { medium: '360x360', thumb: '100x100' },
                              default_url: "/images/:style_picture.png",
                              convert_options: { all: '-strip' }
  validates_attachment :picture, size: { in: 0..500.kilobytes }
  validates_attachment_content_type :picture, content_type: ['image/jpeg', 'image/png']
  validates_attachment_file_name :picture, matches: [/png\z/, /jpe?g\z/]

  # compare text with original_text of card
  def original_text?(text)
    self.original_text.downcase.strip == text.downcase.strip
  end

  def text_distance(text)
    DamerauLevenshtein.distance(self.original_text.downcase.strip, text.downcase.strip)
  end

  def set_review_date
    self.review_date = Time.now
  end
end
