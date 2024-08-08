require_relative '../../errors/payment_not_found'
require_relative '../../errors/payment_not_updateable'
require_relative '../../errors/validate_error'

module ErrorHandle
  extend ActiveSupport::Concern

  included do
    rescue_from ValidateError, with: :handle_not_updateable
    rescue_from PaymentNotUpdateableError, with: :handle_not_updateable
    rescue_from PaymentNotFoundError, with: :handle_payment_not_found
    rescue_from JSON::ParserError, with: :handle_json_parse_error
  end

  private

  def handle_not_updateable(exception)
    render json: create_error(exception.message), status: :unprocessable_entity
  end

  def handle_payment_not_found(exception)
    render json: create_error(exception.message), status: :not_found
  end

  def handle_json_parse_error(exception)
    render json: create_error(exception.message), status: :bad_request
  end

  def create_error(msg)
    { error: msg, timestamps: Time.now }
  end
end
