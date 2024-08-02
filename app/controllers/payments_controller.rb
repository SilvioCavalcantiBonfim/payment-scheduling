class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:register, :get_status]

  def register
    body = JSON.parse(request.body.read, symbolize_names: true)
    payment = Payment.new(pay_at: body[:pay_at])
    raise InvalidDateFormatError unless payment.valid?

    payment.save
    render json: { payment: payment.id }
  end

  def get_status
    id = params[:id]
    
  end
end
