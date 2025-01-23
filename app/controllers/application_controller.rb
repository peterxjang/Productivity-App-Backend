class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  allow_browser versions: :modern
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def current_user
    User.find_by(id: cookies.signed[:user_id])
  end

  def authenticate_user
    unless current_user
      render json: {}, status: :unauthorized
    end
  end
end
