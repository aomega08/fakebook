require 'rails_helper'

describe Payment do
  describe '.all' do
    it 'calls the Coolpay API for all payments' do
      expect(subject.class.coolpay).to receive(:list_payments)
      Payment.all
    end
  end

  describe '#save' do
    it 'calls the Coolpay API to create a payment with the correct arguments' do
      payment = Payment.new(amount: 100, currency: 'GBP', recipient_id: 'me')
      expect(subject.class.coolpay).to receive(:create_payment).with(100, 'GBP', 'me')

      payment.save
    end

    it 'returns false when an error occurs' do
      payment = Payment.new(amount: 100, currency: 'GBP', recipient_id: 'me')
      allow(subject.class.coolpay).to receive(:create_payment).and_raise Coolpay::Errors::ApiError

      expect(payment.save).to be_falsey
    end
  end
end
