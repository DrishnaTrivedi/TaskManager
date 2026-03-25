class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]

  def login
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user, user_id: user.id }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end
end
