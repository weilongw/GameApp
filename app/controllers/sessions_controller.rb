class SessionsController < ApplicationController
  def new
  end

  def create
   geek = Geek.find_by_email(params[:session][:email].downcase)
    if geek && geek.authenticate(params[:session][:password])
      sign_in(geek)
      redirect_back_or geek
    else
      flash.now[:error] = "Invalid User/Password info"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
