require 'ostruct'


class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:create]

  def create
    result = UserRegistrationService.call(user_params)
    if result.success?
      render json: result.user, status: :created
    else
      render json: {errors: result.errors}, status: :unprocessable_entity
    end
  end

  def show
    render json: @user, status: :ok  
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @user.destroy
      render json: {message: "User with name #{@user.name} has been deleted"}, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.expect(user: [:name, :email, :password])
  end

  def set_user
    @user = User.find(params[:id])
  end

end






# POST /api/v1/users          → signup (open)
# POST /api/v1/auth/login     → login, get token (open)
# GET  /api/v1/users/1/tasks  → protected, needs token
# POST /api/v1/users/1/tasks  → protected, needs token
# PUT  /api/v1/users/1/tasks/1 → protected, needs token
# DELETE /api/v1/users/1/tasks/1 → protected, needs token