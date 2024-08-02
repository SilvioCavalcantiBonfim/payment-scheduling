class Payment < ApplicationRecord
  enum status: { pending: 0, paid: 1 }
  # Validar formato da data
  validate :pay_at_format
  # Validar se a data é no futuro
  validate :pay_at_in_future

  def self.update_status
    filter_by_current_datetime_and_status.update_all(status: :pay)
  end

  def self.filter_by_current_datetime_and_status
    current_time = Time.now
    where(
      "EXTRACT(year FROM pay_at) = ? AND
       EXTRACT(month FROM pay_at) = ? AND
       EXTRACT(day FROM pay_at) = ? AND
       EXTRACT(hour FROM pay_at) = ? AND
       EXTRACT(minute FROM pay_at) = ? AND status = ?",
      current_time.year,
      current_time.month,
      current_time.day,
      current_time.hour,
      current_time.min,
      0
    )
  end

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
