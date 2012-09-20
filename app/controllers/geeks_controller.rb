class GeeksController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def new
    @user = Geek.new
  end

  def index
    @users = Geek.page(params[:page])
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

  end

  def update

    if @user.update_attributes(params[:geek])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    Geek.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to geeks_path
  end
  private
    def signed_in_user
      if !signed_in?
        store_location
        flash[:notice] = "Please sign in."
        redirect_to signin_path
      end
    end

    def correct_user
      @user = Geek.find(params[:id])
      if !current_user?(@user)
        redirect_to(root_path)
      end
    end

    def admin_user
      if !current_user.admin?
        redirect_to root_path
      end
    end

end
