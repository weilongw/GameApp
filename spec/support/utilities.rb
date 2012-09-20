def sign_in(geek)
    visit signin_path
    fill_in "Email", with: geek.email
    fill_in "Password", with: geek.password
    click_button "Sign in"

    cookies[:remember_token] = geek.remember_token
end

def full_title(page_title)
  base_title = "ruby on rails"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end
