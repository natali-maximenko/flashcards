require 'rails_helper'

RSpec.describe SuperMemoTutor do
  subject { SuperMemoTutor.new(card: card, review_status: status, response_time: time) }

  let(:card) { create(:card) }
  let(:status) { SuperMemoTutor::CORRECT_RESPONSE }
  let(:time) { 10 }

  describe 'with valid parameters' do
    it { is_expected.to be_a(SuperMemoTutor) }

    context 'call with correct answer' do
      it do
        expect(subject).to receive(:up_review_date)
        subject.call
      end
      it do
        expect(subject).to receive(:update_counters)
        subject.call
      end
      it { expect{ subject.call }.to change(card, :review_count).from(0).to(1) }
      it { expect{ subject.call }.to change(card, :fail_count).from(2).to(0) }
    end

    context 'card' do
      before { subject.call }
      it { expect(card).to have_attributes(efactor: (a_value >= 1.3), interval: 1) }
    end
  end

  describe 'invalid init params' do
    context 'when not card' do
      let(:card) { build(:pack) }
      it { expect{ subject }.to raise_error ArgumentError, 'is not a Card object' }
    end

    context 'when not allowed status' do
      let(:status) { 'status' }
      it { expect{ subject }.to raise_error ArgumentError, 'unknown status' }
    end
  end

  context 'call with incorrect answer' do
    let(:status) { SuperMemoTutor::INCORRECT_RESPONSE }
    let(:card) { create(:card, fail_count: 1) }

    it do
      expect(subject).not_to receive(:up_review_date)
      subject.call
    end
    it do
      expect(subject).to receive(:update_counters)
      subject.call
    end
    it { expect{ subject.call }.to change(card, :fail_count).from(1).to(2) }
    context 'card' do
      before { subject.call }
      it { expect(card).to have_attributes(review_count: 0, efactor: 2.5, interval: 0) }
    end
  end

end
