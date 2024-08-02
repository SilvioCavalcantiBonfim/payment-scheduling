require_relative '../../errors/invalid_date_format'
module ErrorHandle
  extend ActiveSupport::Concern

  included do
    rescue_from InvalidDateFormatError, with: :handle_invalid_date_format
  end

  private

  def handle_invalid_date_format(exception)
    Rails.logger.error("Error: #{exception.message}")
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end
