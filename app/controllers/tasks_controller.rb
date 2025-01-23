class TasksController < ApplicationController
  before_action :authenticate_user

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :priority, :status)
  end

  def index
    @tasks = current_user.tasks
    render :index
  end

  def create
    @task = Task.create(
      user_id: current_user.id,
      session_id: params[:session_id],
      title: params[:title],
      description: params[:description],
      due_date: params[:due_date],
      priority: params[:priority],
      status: params[:status],
    )
    if @task.persisted?
      render :show
    else
      puts "Task errors: #{@task.errors.full_messages}" # Debug logging
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    render :show
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(
      user_id: params[:user_id] || @task.user_id,
      session_id: params[:session_id] || @task.session_id,
      title: params[:title] || @task.title,
      description: params[:description] || @task.description,
      due_date: params[:due_date] || @task.due_date,
      priority: params[:priority] || @task.priority,
      status: params[:status] || @task.status,
    )
    render :show
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    render json: { message: "Task successfully destroyed!" }
  end
end
