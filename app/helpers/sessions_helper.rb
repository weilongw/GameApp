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

  def current_user?(geek)
    geek == current_user
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
