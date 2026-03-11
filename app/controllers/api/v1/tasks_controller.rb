class Api::V1::TasksController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user, only: [:index, :create]
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = @user.tasks
    render json: @tasks, status: :ok
  end

  def create 
    @task = @user.tasks.new(task_params)
    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end 


  def show
    render json: @task, status: :ok
  end
  
  def update
    if @task.update(task_params)
      render json: @task, status: :ok
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  
  def destroy
    @task.destroy
    render json: { message: "Task deleted!" }, status: :ok
  end

  private
  def task_params
    params.expect(task: [:title, :description, :status, :priority, :due_date])
  end

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def set_task
    @task = Task.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Task not found" }, status: :not_found
  end

  
end
