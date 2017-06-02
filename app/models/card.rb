class Card < ApplicationRecord
  validates :original_text, presence: true, length: { minimum: 3 }
  validates :translated_text, presence: true, length: { minimum: 3 }
end
