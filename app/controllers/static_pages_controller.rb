class StaticPagesController < ApplicationController
  def home
  end

  def results
    @result = helpers.player_kit(params[:username])
  end
end