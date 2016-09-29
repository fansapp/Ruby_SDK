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