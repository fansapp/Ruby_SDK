module OptimalPayments
  module HostedPayment
    class Order < JsonObject
      attr_accessor :id
      attr_accessor :merchantRefNum
      attr_accessor :currencyCode
      attr_accessor :totalAmount
      attr_accessor :customerIp
      attr_accessor :customerNotificationEmail
      attr_accessor :merchantNotificationEmail
      attr_accessor :dueDate
      attr_accessor :profile
      attr_accessor :shoppingCart
      attr_accessor :ancillaryFees
      attr_accessor :billingDetails
      attr_accessor :shippingDetails
      attr_accessor :callback
      attr_accessor :redirect
      attr_accessor :link
      attr_accessor :mode
      attr_accessor :type
      attr_accessor :paymentMethod
      attr_accessor :addendumData
      attr_accessor :locale
      attr_accessor :extendedOptions
      attr_accessor :associatedTransactions
      attr_accessor :transaction
      attr_accessor :error

      def self.get_pageable_array_key
        "records"
      end

      def get_link link_name
        unless @link.empty?
          @link.each do |link|
            return link if link[:rel] == link_name
          end
        end

        raise OptimalError, "Link #{link_name} not found in order."
      end
    end
  end
end