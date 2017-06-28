def check_card(text)
  visit root_path
  fill_in :user_text, with: text.to_s
  click_button I18n.t('home.index.check')
end
