require 'rails_helper'

describe Recipient do
  describe '.find' do
    it 'calls the Coolpay API to search a recipient' do
      expect(subject.class.coolpay).to receive(:find_recipient).with('francesco').and_return([])
      Recipient.find('francesco')
    end
  end

  describe '#save' do
    it 'calls the Coolpay API to create a recipient' do
      recipient = Recipient.new(name: 'John')
      expect(subject.class.coolpay).to receive(:create_recipient).with('John')

      recipient.save
    end

    it 'returns false when an error occurs' do
      recipient = Recipient.new(name: 'It\'s me, Mario!')
      allow(subject.class.coolpay).to receive(:create_recipient).and_raise Coolpay::Errors::ApiError
      expect(recipient.save).to be_falsey
    end
  end
end
