class CoolpayModel
  # Yes, I'm writing to a class variable.
  #
  # The Coolpay::Client class keeps a token inside, and doing this prevents
  # asking for a new authentication token for each and every operation on the
  # frontend.
  #
  # I had a few alternatives, like storing the token in the user session, but
  # why? The credentials are the same for every user...
  def self.coolpay
    @@coolpay ||= Coolpay::Client.new(ENV['COOLPAY_USER'], ENV['COOLPAY_SECRET'])
  end
end
