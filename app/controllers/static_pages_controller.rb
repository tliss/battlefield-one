class StaticPagesController < ApplicationController
  def home
  end

  def results
    if KitList.count == 0 || KitList.exists?(origin_user: params[:origin_search_user])
      @result = helpers.player_kit(params[:origin_search_user])
    end
    @result = KitList.find_by(origin_user: params[:origin_search_user])
  end
end