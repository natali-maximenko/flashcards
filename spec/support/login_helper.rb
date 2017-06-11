def login(email, password)
  visit login_path
  fill_in :email, with: email
  fill_in :password, with: password
  click_button "Войти"
end
