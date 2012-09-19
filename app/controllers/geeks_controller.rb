class GeeksController < ApplicationController
  def new
    @user = Geek.new
  end

  def show
    @user = Geek.find(params[:id])
  end

  def create
    @user = Geek.new(params[:geek])
    if @user.save
      flash[:success]="Welcome to GameApp"
      redirect_to @user
    else
      render 'new'
    end
  end
end
