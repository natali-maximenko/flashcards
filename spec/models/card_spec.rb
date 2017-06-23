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
    before do
      date = Date.today
      time = Time.local(date.year, date.month, date.day, 10, 0, 0)
      Timecop.freeze(time)
    end
    it { is_expected.to be_valid }

    context 'review_date before create' do
      it { expect(card.review_date).to eq(2.days.ago) }
    end

    context 'review_date after create' do
      let(:created_card) { create :card }
      it { expect(created_card.review_date).to eq(Time.now) }
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

  describe '#text_distance' do
    subject { card.text_distance(text) }

    context 'when text is correct' do
      let(:card) { build :card }
      let(:text) { 'mit' }
      it { is_expected.to eq(0) }
    end

    context 'when misprint' do
      let(:card) { build :card }
      let(:text) { 'mti' }
      it { is_expected.to eq(1) }
    end
  end

  describe 'SuperMemoTutor' do
    subject(:card) { create :card }
    before do
      date = Date.today
      time = Time.local(date.year, date.month, date.day, 10, 0, 0)
      Timecop.freeze(time)
    end

    context 'second review fails first time' do
      before { card.update(review_count: 2) }

      it { expect{ SuperMemoTutor.new(card, :incorrect).recalculate }.to change(card, :fail_count).from(0).to(1) }
    end

    context 'second review fails 3 times' do
      before do
        card.update(review_count: 2, fail_count: 2)
        SuperMemoTutor.new(card, :incorrect).recalculate
      end

      it { expect(card).to have_attributes(review_count: 1, fail_count: 0, review_date: Time.now) }
    end

    context 'second review checked after 2 fails' do
      before do
        card.update(review_count: 2, fail_count: 2)
        SuperMemoTutor.new(card, :corrent, 30).recalculate
      end

      it { expect(card).to have_attributes(review_count: 3, fail_count: 0) }
    end
  end
end
