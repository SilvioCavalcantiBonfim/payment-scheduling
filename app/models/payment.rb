class Payment < ApplicationRecord
  enum status: { pending: 0, paid: 1 }
  # Validar formato da data
  validate :pay_at_format
  # Validar se a data é no futuro
  validate :pay_at_in_future

  def self.update_status
    puts filter_by_datetime_and_status.update_all(status: :paid)
  end

  def self.filter_by_datetime_and_status
    current_time = Time.now
    date_time = format_date_time(current_time)

    where(
      "strftime('%Y-%m-%d %H:%M', pay_at) = ? AND status = ?",
      date_time,
      statuses[:pending]
    )
  end

  # Formata a data e a hora para o formato 'YYYY-MM-DD HH:MM'
  def self.format_date_time(time)
    time.strftime('%Y-%m-%d %H:%M')
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
