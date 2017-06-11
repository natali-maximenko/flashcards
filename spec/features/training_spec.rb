require 'rails_helper'

describe 'card review page' do
  let!(:user) { create(:user_with_cards) }

  before :each do
    login('test@gmail.com', 'paSsWodD')
    check_card(text)
  end

  context 'see home page with training program' do
    let(:text) { '' }
    it { expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек' }
  end

  context 'have cards to review' do
    let(:text) { '' }
    it { expect(page).not_to have_content 'Нечего повторять!' }
  end

  context 'wrong word' do
    let(:text) { 'blabla' }
    it { expect(page).to have_content 'Ошибочка вышла, попробуй ещё раз.' }
  end

  context 'correct word' do
    let(:text) { 'mit' }
    it { expect(page).to have_content 'Верно! Продолжай.' }
  end
end
