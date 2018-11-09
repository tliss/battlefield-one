class KitListUsersController < ApplicationController
    def create
        KitListUser.create(user_id: params[:user_id], kit_list_id: params[:kit_list_id])
    end
end
