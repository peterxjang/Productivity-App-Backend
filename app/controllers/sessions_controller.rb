class SessionsController < ApplicationController
  before_action :authenticate_user

  def index
    @sessions = current_user.sessions
    render :index
  end

  def create
    puts "Incoming parameters: #{params.inspect}" # Debug logging

    @session = Session.create(
      user_id: current_user.id, # Use current_user instead of params
      started_at: params[:started_at],
      ended_at: params[:ended_at],
      duration_minutes: params[:duration_minutes],
      session_type: params[:session_type],
    )

    if @session.persisted?
      render :show
    else
      puts "Session errors: #{@session.errors.full_messages}" # Debug logging
      render json: { errors: @session.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @session = Session.find_by(id: params[:id])
    render :show
  end

  def update
    @session = Session.find_by(id: params[:id])
    @session.update(
      user_id: params[:user_id] || @session.user_id,
      started_at: params[:started_at] || @session.started_at,
      ended_at: params[:ended_at] || @session.ended_at,
      duration_minutes: params[:duration_minutes] || @session.duration_minutes,
      session_type: params[:session_type] || @session.session_type,
    )
    render :show
  end

  def destroy
    @session = Session.find_by(id: params[:id])
    @session.destroy
    render json: { message: "Session successfully destroyed!" }
  end
end
