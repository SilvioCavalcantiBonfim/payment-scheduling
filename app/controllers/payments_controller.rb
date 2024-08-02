class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[register status]

  before_action :find_by_id, only: %i[status]
  def register
    body = JSON.parse(request.body.read, symbolize_names: true)
    payment = Payment.new(pay_at: body[:pay_at])
    raise InvalidDateFormatError unless payment.valid?

    payment.save
    render json: { payment: payment.id }
  end

  def status
    render json: @payment, only: [:status]
  end

  private

  def find_by_id
    @payment = Payment.find_by({ id: params[:id] })

    raise PaymentNotFoundError, 'Payment not found.' unless @payment
  end
end
