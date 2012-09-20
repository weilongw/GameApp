module SessionsHelper
  def sign_in(geek)
    cookies.permanent[:remember_token] = geek.remember_token
    self.current_user = geek
  end

  def current_user=(geek)
    @current_user = geek
  end

  def current_user
    @current_user ||= Geek.find_by_remember_token(cookies[:remember_token])
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
