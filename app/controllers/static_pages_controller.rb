class StaticPagesController < ApplicationController
  def home
    @play = current_user.plays.build if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end


end
