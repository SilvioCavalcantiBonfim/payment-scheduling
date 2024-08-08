class PaymentsController < ApplicationController
  before_action :find_by_id, only: %i[show update]

  before_action :parse_body, only: %i[new update]

  def new
    payment = Payment.create!({ pay_at: @pay_at })
    render json: { payment: payment.id }
  rescue StandardError => e
    raise ValidateError, e.message
  end

  def show
    render json: @payment, only: %i[status pay_at]
  end

  def update
    @payment.update!({ pay_at: @pay_at })
    render json: @payment, only: %i[status pay_at]
  rescue StandardError => e
    raise ValidateError, e.message
  end

  private

  def find_by_id
    @payment = Payment.find_by({ id: params[:id] })
    raise PaymentNotFoundError, 'Payment not found.' unless @payment
  end

  def parse_body
    body = JSON.parse(request.body.read, symbolize_names: true)
    @pay_at = DateTime.parse(body[:pay_at])
  rescue StandardError
    raise JSON::ParserError, 'Invalid date format.'
  end
end
