class KitListsController < ApplicationController

  def process_kit_list
    unless KitList.count >= 0 && KitList.exists?(origin_user: params[:origin_search_user])
      helpers.add_player_kit(params[:origin_search_user])
    end
    @result = KitList.find_by(origin_user: params[:origin_search_user])
    redirect_to(@result)
  end

  def show
    # @result = KitList.find_by(origin_user: params[:id])
    @result = KitList.find_by_id(params[:id])
    @klu = KitListUser.new
  end
end
