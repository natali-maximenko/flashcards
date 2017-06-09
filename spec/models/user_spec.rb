require 'rails_helper'

RSpec.describe User, type: :model do
  context 'empty user' do
    subject { build(:empty_user) }
    it { is_expected.not_to be_valid }
  end

  context 'normal user' do
    subject { build(:user) }
    it { is_expected.to be_valid }
  end

  context 'user with cards' do
    subject(:user) { create(:user_with_cards) }
    it { expect(user.cards).not_to be_empty }
  end
end
