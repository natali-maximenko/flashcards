require 'rails_helper'

describe 'Accessing user' do
  let!(:user) { create(:user) }
  before :each do
    visit root_path
  end

  it 'redirect to login' do
    expect(page).to have_content 'Нужно залогиться'
  end

  it 'does not show user menu' do
    expect(page).not_to have_content 'Мои колоды'
  end

  it 'show registration button' do
    expect(page).to have_content 'Регистрация'
  end

  context 'after login' do
    before :each do
      login('test@gmail.com', 'paSsWodD')
    end

    it 'show home page' do
      expect(page).to have_content 'Первый в мире удобный менеджер флеш-карточек'
    end

    it 'show user menu' do
      expect(page).to have_content 'Добавить колоду'
    end

    it 'does not show login link' do
      expect(page).not_to have_content 'Войти'
    end

    context 'profile menu' do
      before :each do
        click_on 'test@gmail.com'
      end

      it 'show edit profile link' do
        expect(page).to have_content 'Редактировать профиль'
      end

      it 'show log out link' do
        expect(page).to have_content 'Выйти'
      end
    end
  end
end
