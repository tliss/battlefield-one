class KitListsController < ApplicationController

  def index
    unless KitList.count >= 0 && KitList.exists?(origin_user: params[:origin_search_user])
      helpers.add_player_kit(params[:origin_search_user])
    end
    @result = KitList.find_by(origin_user: params[:origin_search_user])
  end

  def show
    @result = KitList.find_by(origin_user: params[:id])
  end
end
