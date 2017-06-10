class User < ApplicationRecord
  authenticates_with_sorcery!

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :password, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :cards, dependent: :destroy
end
