module OptimalPayments
  module HostedPayment
    class Card < JsonObject
      attr_accessor :brand
      attr_accessor :country
      attr_accessor :expiry
      attr_accessor :lastDigits
      attr_accessor :threeDEnrolment
      attr_accessor :type
    end
  end
end