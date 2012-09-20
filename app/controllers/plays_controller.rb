class PlaysController < ApplicationController
  before_filter :signed_in_user

  def create
    @play = current_user.plays.build(params[:play])
    if @play.save
      flash[:success] = "Well played"
      redirect_to root_path
    else
      render 'static_pages/home'
    end
  end

  def destroy

  end
end