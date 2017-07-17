require 'rails_helper'

describe 'create card' do
  let!(:user) { create(:user_with_packs) }

  before(:each) do
    login('test@gmail.com', 'paSsWodD')
    visit new_pack_card_path(user.packs.first)
    fill_in 'оригинал', with: 'test'
    fill_in 'перевод', with: 'Tест'
    attach_file 'card_picture', "#{::Rails.root}/spec/support/fixtures/ciklon.jpg"
    click_button('Создать')
  end

  it 'contain new card in list' do
    expect(page).to have_content 'test'
  end

  it 'view created card' do
    link = all('a.show_card').last
    visit link
    expect(page).to have_xpath "//img[contains(@src, 'ciklon.jpg')]"
  end
end
