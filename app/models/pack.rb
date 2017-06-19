class Pack < ApplicationRecord
  validates :name, presence: true

  has_many :cards
  belongs_to :user
end
