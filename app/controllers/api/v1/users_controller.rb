class Api::V1::UsersController < ApplicationController
    before_action :authorize_request
    
    def check_logged_user
        render json: 'ok'
    end
  
    def get_user_details
        render json: @current_user
    end
  
    def update_user_details
        return render json: {errors: @current_user.errors.full_messages}, status: :bad_request unless @current_user.update(user_params)
        render json: @current_user
    end


    private

    def user_params
        params.permit(:first_name, :last_name)
    end
  end