module OptimalPayments
  module HostedPayment
    class Refund < JsonObject
      attr_accessor :id
      attr_accessor :merchantRefNum
      attr_accessor :originalMerchantRefNum
      attr_accessor :amount
      attr_accessor :currencyCode
      attr_accessor :authType
      attr_accessor :confirmationNumber
      attr_accessor :mode
      attr_accessor :orderID
    end
  end
end