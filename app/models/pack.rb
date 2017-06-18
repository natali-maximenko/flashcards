class Pack < ApplicationRecord
  validates :name, presence: true
  scope :current, -> { where(current: true) }

  has_many :cards
  belongs_to :user
end
