require 'securerandom'

class Payment < ApplicationRecord
  enum status: %i[pending paid]

  validates_presence_of :pay_at
  validate :future
  validate :updatable

  before_create :generate_uuid

  def future
    return unless pay_at

    errors.add(:pay_at, 'Must be in the future.') unless pay_at > Time.now
  end

  def generate_uuid
    self.id ||= SecureRandom.alphanumeric(10)
  end

  def updatable
    errors.add(:status, 'The payment cannot be updated because its current status is not pending.') unless pending?
  end
end
