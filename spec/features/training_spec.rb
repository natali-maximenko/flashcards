require 'rails_helper'

describe 'card review page', js: true do
  let!(:user) { create(:user_with_packs) }

  before(:each) do
    visit login_path
    fill_in :email, with: 'test@gmail.com'
    fill_in :password, with: 'paSsWodD'
    click_button 'Login'
  end

  it 'see home page with training program' do
    visit root_path
    expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек'
  end

  it 'have cards to review' do
    visit root_path
    expect(page).not_to have_content 'Нечего повторять!'
  end

  it 'wrong word' do
    check_card :blabla
    expect(page).to have_css('#flash', text: 'Ошибочка вышла, попробуй ещё раз.')
  end

  it 'correct word' do
    check_card :mit
    expect(page).to have_css('#flash', text: 'Верно! Продолжай.')
  end

  it 'misprint' do
    check_card :mti
    expect(page).to have_css('#flash', text: 'Опечатка. Правильно так: mit, а ввели mti.')
  end
end
