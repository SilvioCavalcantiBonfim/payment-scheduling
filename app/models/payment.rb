class Payment < ApplicationRecord
  enum status: { pending: 0, paid: 1 }
  # Validar formato da data
  validate :pay_at_format
  # Validar se a data é no futuro
  validate :pay_at_in_future

  private

  def pay_at_format
    errors.add(:pay_at, 'is not a valid date format') if pay_at.nil?
  end

  def pay_at_in_future
    return if pay_at.blank?

    return unless pay_at <= Time.current

    errors.add(:pay_at, 'must be in the future')
  end
end
