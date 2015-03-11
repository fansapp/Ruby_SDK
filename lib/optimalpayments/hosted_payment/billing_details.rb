module OptimalPayments
  module HostedPayment
    class BillingDetails < JsonObject
      attr_accessor :street
      attr_accessor :street2
      attr_accessor :city
      attr_accessor :state
      attr_accessor :country
      attr_accessor :zip
      attr_accessor :phone
      attr_accessor :useAsShippingAddress
    end
  end
end