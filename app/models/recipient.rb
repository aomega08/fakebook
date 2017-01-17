class Recipient < CoolpayModel
  attr_accessor :name

  # Only from API
  attr_accessor :id

  def self.find(name)
    coolpay.find_recipient(name).map do |raw_recipient|
      Recipient.new(raw_recipient)
    end
  end

  def save
    self.class.coolpay.create_recipient(name)
  rescue StandardError => e
    Rails.logger.error("Error while saving recipient: #{e}")
    false
  end
end
