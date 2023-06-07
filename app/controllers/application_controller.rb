class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_invalid_response
  rescue_from StandardError, with: :render_invalid_request

  def render_invalid_response(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: :not_found
  end

  def render_invalid_request(exception)
    render json: ErrorSerializer.new(exception.message).invalid_request, status: :bad_request
  end
end
