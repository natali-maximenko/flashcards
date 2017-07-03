def check_card(text)
  visit review_path
  fill_in :user_text, with: text.to_s
  click_button I18n.t('dashboard.home.index.check')
end
