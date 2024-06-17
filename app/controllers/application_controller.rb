class ApplicationController < ActionController::API
    
  private
  
  def authorize_request
    header = request.headers[:Authorization]
    header = header.split(' ').last if header.present?
    begin
      @current_user = User.find(JsonWebToken.decode(header)[:user_id])
    rescue JWT::DecodeError => e
      return render json: { errors: [e.message] }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound => e
      return render json: { errors: 'User not found' }, status: :unauthorized
    end
  
  end
end
