class Payment < CoolpayModel
  include ActiveModel::Model

  attr_accessor :amount, :currency, :recipient_id

  def self.all
    coolpay.list_payments
  end

  def save
    self.class.coolpay.create_payment(amount, currency, recipient_id)
  rescue StandardError => e
    Rails.logger.error("Error while saving payment: #{e}")
    false
  end
end
