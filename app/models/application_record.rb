require 'securerandom'

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  before_create :generate_uuid

  private

  def generate_uuid
    return if self.class.attribute_types['id'].type != :string

    self.id ||= SecureRandom.alphanumeric(10)
  end
end
