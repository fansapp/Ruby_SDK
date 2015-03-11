module OptimalPayments
  module HostedPayment
    class Settlement < JsonObject
      attr_accessor :id
      attr_accessor :amount
      attr_accessor :merchantRefNum
      attr_accessor :authType
      attr_accessor :confirmationNumber
      attr_accessor :currencyCode
      attr_accessor :mode
      attr_accessor :originalMerchantRefNum
      attr_accessor :orderID
    end
  end
end