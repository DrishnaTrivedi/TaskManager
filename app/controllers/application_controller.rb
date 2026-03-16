class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include ExceptionHandler

  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    raise ExceptionHandler::MissingToken, "Missing token" unless token
    
    @decoded = JsonWebToken.decode(token)
    @current_user = User.find(@decoded[:user_id])

  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :unauthorized
  rescue ExceptionHandler::InvalidToken => e
    render json: { error: e.message }, status: :unauthorized
  rescue ExceptionHandler::MissingToken => e
    render json: { error: e.message }, status: :unauthorized
  end
end