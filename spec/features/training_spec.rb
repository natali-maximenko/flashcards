require 'rails_helper'

describe 'card review page' do
  before do
    card = create(:card)
    card.review_date = 3.days.ago
    card.save
    visit root_path
  end

  context 'see home page with training program' do
    it { expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек' }
  end

  context 'have cards to review' do
    it { expect(page).not_to have_content 'Нечего повторять!' }
  end

  describe 'check card' do
    before do
      fill_in :user_text, with: text
      click_button 'Проверить!'
    end

    context 'correct word' do
      let(:text) { Card.find(find_by_id('id', :visible => :all).value)[:original_text] }
      it { expect(page).to have_content 'Верно! Продолжай.' }
    end

    context 'wrong word' do
      let(:text) { 'blabla' }
      it { expect(page).to have_content 'Ошибочка вышла, попробуй ещё раз.' }
    end
  end
end
