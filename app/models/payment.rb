class Payment < ApplicationRecord
  enum status: { pending: 0, paid: 1 }

  def self.update_status
    puts filter_by_datetime_and_status.update_all(status: :paid)
  end

  def self.filter_by_datetime_and_status
    current_time = Time.now
    date_time = current_time.strftime('%Y-%m-%d %H:%M')

    where(
      "strftime('%Y-%m-%d %H:%M', pay_at) = ? AND status = ?",
      date_time,
      statuses[:pending]
    )
  end
end
