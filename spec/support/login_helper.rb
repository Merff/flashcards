def login(email, password)
  visit root_path
  click_link (I18n.t :sign_in)
  fill_in :email,    with: email
  fill_in :password, with: password
  click_button (I18n.t :sign_in)
end