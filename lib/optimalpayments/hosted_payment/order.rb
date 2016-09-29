<<-DOC
 * Copyright (c) 2016 Paysafe
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
 * associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute,
 * sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
 * NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 DOC

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