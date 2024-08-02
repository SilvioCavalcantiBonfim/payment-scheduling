class InvalidDateFormatError < StandardError
  def initialize(message = 'The date format is invalid or the date is in the past')
    super(message)
  end
end
