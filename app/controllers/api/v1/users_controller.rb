class Api::V1::UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: [:show, :update, :destroy]

  def create 
    user = User.new(user_params)
    if user.save
      WelcomeEmailJob.perform_later(user.id)
      render json:user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
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
