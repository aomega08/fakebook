class Payment < CoolpayModel
  attr_accessor :amount, :currency, :recipient_id

  # Only from API
  attr_accessor :status, :id

  def self.all
    coolpay.list_payments.map do |raw_payment|
      Payment.new(raw_payment)
    end
  end

  def save
    self.class.coolpay.create_payment(amount, currency, recipient_id)
  rescue StandardError => e
    Rails.logger.error("Error while saving payment: #{e}")
    false
  end
end
