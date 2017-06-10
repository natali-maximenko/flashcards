require 'rails_helper'

# describe 'card review page' do
#   let!(:card) do
#     card = create(:haben_card)
#     card.review_date = 7.days.ago
#     card.save
#     card
#   end
#   let!(:haben_card) do
#     c = create(:haben_card)
#     c.review_date = 3.days.ago
#     c.save
#     c
#   end
#   before :each do
#     check_card(text)
#   end

#   context 'see home page with training program' do
#     let(:text) { '' }
#     it { expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек' }
#   end

#   context 'have cards to review' do
#     let(:text) { '' }
#     it { expect(page).not_to have_content 'Нечего повторять!' }
#   end

#   context 'wrong word' do
#     let(:text) { 'blabla' }
#     it { expect(page).to have_content 'Ошибочка вышла, попробуй ещё раз.' }
#   end

#   context 'correct word' do
#     let(:text) { 'haben' }
#     it { expect(page).to have_content 'Верно! Продолжай.' }
#   end
# end
