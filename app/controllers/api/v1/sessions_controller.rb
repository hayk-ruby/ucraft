# frozen_string_literal: true

class Api::V1::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_for_database_authentication(email: params[:email]) 
    if user&.valid_password?(params[:password])
      sign_in(user)
      
      token = JsonWebToken.encode(user_id: user.id)
      
      return render json: {
        token: token,
      }, status: :accepted
    end

    render json: { errors: 'Invalid login or password' }, status: :unauthorized
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
