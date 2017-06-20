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
  validates :review_date, presence: true
  before_create :set_review_date
  validates_with CardTextValidator
  scope :need_review, -> { where('review_date <= ?', Date.today) }
  scope :random, -> { order('RANDOM()') }

  belongs_to :pack

  has_attached_file :picture, styles: { medium: '360x360', thumb: '100x100' }, default_url: "/images/:style_picture.png", convert_options: { all: '-strip' }
  validates_attachment :picture, presence: true, content_type: { content_type: ['image/jpeg', 'image/png'] }, size: { in: 0..500.kilobytes }
  validates_attachment_file_name :picture, matches: [/png\z/, /jpe?g\z/]

  # compare text with original_text of card
  def original_text?(text)
    self.original_text.downcase.strip == text.downcase.strip
  end

  # when card checked, need to update counters and review_date
  # @param status [bool] checked or not
  def checked(status)
    if status
      self.review_count += 1
      self.fail_count = 0
      up_review_date
    else
      self.fail_count += 1
      check_fails
    end
  end

private
  def check_fails
    clean_card if self.fail_count == REVIEW_FAILS_LIMIT
  end

  # when many fails, return card to first review state
  def clean_card
    self.fail_count = 0
    self.review_count = 1
    up_review_date
  end

  def up_review_date
    self.review_date = Time.now + REVIEW_INTERVALS[self.review_count]
  end

  def set_review_date
    self.review_date = Time.now
  end
end
