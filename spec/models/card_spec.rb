require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'empty card' do
    subject { build :empty_card }
    it { is_expected.not_to be_valid }
  end

  describe 'normal card' do
    subject(:card) { build :card }
    it { is_expected.to be_valid }

    context 'review_date before create' do
      it { expect(card.review_date).to eq(Date.today) }
    end

    context 'review_date after create' do
      let(:created_card) { create :card }
      it { expect(created_card.review_date).to eq(Date.today + 3) }
    end
  end
  # it "has a valid factory"
  # it "is invalid without a firstname"
  # it "is invalid without a lastname"
  # it "returns a contact's full name as a string"
end
