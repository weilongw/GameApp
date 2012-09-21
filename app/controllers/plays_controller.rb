class PlaysController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy]

  def create
    @play = current_user.plays.build(params[:play])
    if @play.save
      flash[:success] = "Well played"

    else
      flash[:notice] = "You shall not pass"
    end
    redirect_to root_path
  end

  def destroy
     @play.destroy
     redirect_to root_path
  end

  private
    def correct_user
      @play = current_user.plays.find_by_id(params[:id])
      if @play.nil?
        redirect_to root_path
      end
    end
end