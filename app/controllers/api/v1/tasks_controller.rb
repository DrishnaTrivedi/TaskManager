# require 'kaminari'
class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = @current_user.tasks

    # filtering
    @tasks = @tasks.where(status: params[:status])                          if params[:status].present?
    @tasks = @tasks.where(priority: params[:priority])                      if params[:priority].present?
    @tasks = @tasks.where("title LIKE ?", "%#{params[:search]}%")           if params[:search].present?

    @tasks = @tasks.page(params[:page]).per(params[:per_size] || 5)
    render json: {
      tasks: @tasks,
      meta: {
        current_page: @tasks.current_page,
        total_pages: @tasks.total_pages,
        total_count: @tasks.total_count,
        per_page: @tasks.limit_value
      }
    }, status: :ok
  end

  def create
    @task = @current_user.tasks.new(task_params)
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

  def set_task
    @task = @current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Task not found" }, status: :not_found
  end
end