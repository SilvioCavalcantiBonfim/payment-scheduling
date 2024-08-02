require_relative '../../errors/invalid_date_format'
require_relative '../../errors/payment_not_found'
module ErrorHandle
  extend ActiveSupport::Concern

  included do
    rescue_from PastDateError, with: :handle_past_date
    rescue_from PaymentNotFoundError, with: :handle_payment_not_found
    rescue_from JSON::ParserError, with: :handle_json_parse_error
  end

  private

  def handle_past_date(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def handle_payment_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def handle_json_parse_error(_exception)
    render json: { error: 'Invalid data format' }, status: :bad_request
  end
end
