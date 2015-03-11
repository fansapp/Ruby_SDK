module OptimalPayments
  module HostedPayment
    class Transaction < JsonObject
      attr_accessor :status
      attr_accessor :lastUpdate
      attr_accessor :authType
      attr_accessor :authCode
      attr_accessor :merchantRefNum
      attr_accessor :associatedTransactions
      attr_accessor :card
      attr_accessor :confirmationNumber
      attr_accessor :currencyCode
      attr_accessor :amount
      attr_accessor :paymentType
      attr_accessor :settled
      attr_accessor :refunded
      attr_accessor :reversed
      attr_accessor :dateTime
      attr_accessor :reference
      attr_accessor :cvdVerification
      attr_accessor :houseNumberVerification
      attr_accessor :zipVerification
      attr_accessor :riskReasonCode
      attr_accessor :errorCode
      attr_accessor :errorMessage
    end
  end
end