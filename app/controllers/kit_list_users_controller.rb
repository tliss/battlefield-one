class KitListUsersController < ApplicationController
    def create
        KitListUser.create(user_id: params[:user_id], kit_list_id: params[:kit_list_id])
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end

    def destroy
        KitListUser.destroy(user_id: params[:user_id], kit_list_id: params[:kit_list_id])
        respond_to do |format|
            format.html { redirect_to @user }
            format.js
        end
    end
end
