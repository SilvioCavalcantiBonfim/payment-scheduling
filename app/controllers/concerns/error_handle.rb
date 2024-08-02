require_relative '../../errors/invalid_date_format'
require_relative '../../errors/payment_not_found'
module ErrorHandle
  extend ActiveSupport::Concern

  included do
    rescue_from InvalidDateFormatError, with: :handle_invalid_date_format
    rescue_from PaymentNotFoundError, with: :handle_payment_not_found
  end

  private

  def handle_invalid_date_format(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def handle_payment_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end
end
