class StaticPagesController < ApplicationController
  def home

    # @result = helpers.player_kit
    @result = helpers.weapons

  end

  def results
  end
end