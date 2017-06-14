require 'rails_helper'

RSpec.describe Card, type: :model do
  context 'empty card' do
    subject { build :empty_card }
    it { is_expected.not_to be_valid }
  end

  context 'when original and translated text are the same' do
    subject { build(:card, translated_text: 'mit') }
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

  describe 'picture' do
    subject { create :card }

    context 'card has picture' do
      it { is_expected.to have_attached_file(:picture) }
    end

    context 'card attachment is image' do
      it do
        is_expected.to validate_attachment_content_type(:picture).
                        allowing('image/png', 'image/jpeg').
                        rejecting('text/plain', 'text/xml')
      end
    end

    context 'card attachment size < 500 Kb' do
      it { is_expected.to validate_attachment_size(:picture).less_than(500.kilobytes) }
    end
  end

  describe '#original_text?' do
    subject { card.original_text?(text) }

    context 'when text is wrong' do
      let(:card) { build :card }
      let(:text) { 'text' }
      it { is_expected.to be false }
    end

    context 'when text is correct' do
      let(:card) { build :card }
      let(:text) { 'mit' }
      it { is_expected.to be true }
    end

    context 'when text is correct case insensitive' do
      let(:card) { build :card }
      let(:text) { 'Mit ' }
      it { is_expected.to be true }
    end
  end

  describe '#up_review_date' do
    subject(:card) do
      card = build :card
      card.up_review_date
    end
    it { is_expected.to eq(Date.today + 3) }
  end
end
