class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :password, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }

  has_many :cards
end
