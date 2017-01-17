class Recipient < CoolpayModel
  include ActiveModel::Model

  attr_accessor :name

  def self.find(name)
    coolpay.find_recipient(name)
  end

  def save
    self.class.coolpay.create_recipient(name)
  rescue StandardError => e
    Rails.logger.error("Error while saving recipient: #{e}")
    false
  end
end
