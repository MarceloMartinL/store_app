module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    # Define custom handlers
    rescue_from Exception do |e|
      json_response({ message: e.message, backtrace: e.backtrace[0..10] }, :internal_server_error)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end
end