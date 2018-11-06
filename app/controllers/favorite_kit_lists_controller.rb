class FavoriteKitListsController < ApplicationController
    before_action :authenticate_user!

    def create
        @kit_list = Kit_List.find(params[:kit_list_id])
        current_user.favorite(@kit_list)
        respond_to do |format|
            format.html { redirect_to @kit_list }
            format.js
        end
    end
  
    def destroy
    end
end
