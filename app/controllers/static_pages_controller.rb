class StaticPagesController < ApplicationController
  def home

    @result = helpers.player_kit

  end

  def results
  end
end