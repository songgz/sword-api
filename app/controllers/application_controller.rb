class ApplicationController < ActionController::API
  #rescue_from StandardError {|e| handle_error(e) }
  include Pagination


  private
  def error(e)
    render json: { error: "#{e.class.name} : #{e.message}" }, status: :internal_server_error
  end

  def not_authorized
    render json: { error: "Not authorized" }, status: :unauthorized
  end

  def not_found
    render json: { error: "not found" }, status: :not_found
  end

end
