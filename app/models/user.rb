class User < ApplicationRecord
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: true

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :packs, dependent: :destroy
  has_many :cards, through: :packs, dependent: :destroy
  belongs_to :current_pack, class_name: 'Pack', foreign_key: :current_pack_id, required: false
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications

  def self.notify_cards_need_review
    User.joins(:cards).where('review_date <= ?', Time.now) do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end
