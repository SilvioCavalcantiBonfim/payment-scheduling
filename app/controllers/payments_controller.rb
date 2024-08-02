class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[new show update]

  before_action :find_by_id, only: %i[show update]

  before_action :parse_body, only: %i[new update]

  def new
    payment = Payment.new(pay_at: @pay_at)
    payment.save
    render json: { payment: payment.id }
  end

  def show
    render json: @payment, only: %i[status pay_at]
  end

  def update
    raise PaymentNotUpdateableError, '' if @payment.status == Payment.statuses[:pending]

    @payment.update({ pay_at: @pay_at })
    render json: @payment, only: %i[status pay_at]
  end

  private

  def find_by_id
    @payment = Payment.find_by({ id: params[:id] })
    raise PaymentNotFoundError, 'Payment not found.' unless @payment
  end

  def parse_body
    begin
      body = JSON.parse(request.body.read, symbolize_names: true)
      @pay_at = DateTime.parse(body[:pay_at])
    rescue StandardError
      raise JSON::ParserError, 'Invalid date format.'
    end
    raise InvalidDateFormatError, 'must be in the future.' if @pay_at <= Time.current
  end
end
