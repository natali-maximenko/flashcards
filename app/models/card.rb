class Card < ApplicationRecord
  validates :original_text, presence: true, length: { minimum: 3 }, uniqueness: true
  validates :translated_text, presence: true, length: { minimum: 3 }, uniqueness: true
end
