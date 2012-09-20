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
      sign_in @user
      flash[:success]="Welcome to GameApp"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = Geek.find(params[:id])
  end

  def update
    @user = Geek.find(params[:id])
    if @user.update_attributes(params[:geek])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
end
