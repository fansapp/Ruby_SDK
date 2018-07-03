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


require_relative "optimalpayments/card_payment_service"
require "optimalpayments/customer_vault_service"
require "optimalpayments/environment"
require "optimalpayments/hosted_payment_service"
require "optimalpayments/json_object"
require "optimalpayments/optimal_api_client"
require "optimalpayments/pagerator"
require "optimalpayments/request"

require "optimalpayments/card_payments/authentication"
require "optimalpayments/card_payments/authorization"
require "optimalpayments/card_payments/authorization_reversal"
require "optimalpayments/card_payments/billing_details"
require "optimalpayments/card_payments/profile"
require "optimalpayments/card_payments/refund"
require "optimalpayments/card_payments/settlement"
require "optimalpayments/card_payments/shipping_details"
require "optimalpayments/card_payments/verification"
require "optimalpayments/card_payments/split_pay"
require "optimalpayments/card_payments/store_credential"

require "optimalpayments/customer_vault/address"
require "optimalpayments/customer_vault/card"
require "optimalpayments/customer_vault/profile"

require "optimalpayments/hosted_payment/billing_details"
require "optimalpayments/hosted_payment/card"
require "optimalpayments/hosted_payment/order"
require "optimalpayments/hosted_payment/refund"
require "optimalpayments/hosted_payment/settlement"
require "optimalpayments/hosted_payment/shipping_details"
require "optimalpayments/hosted_payment/transaction"

require "optimalpayments/errors/optimal"
require "optimalpayments/errors/api"
require "optimalpayments/errors/entity_not_found"
require "optimalpayments/errors/invalid_credentials"
require "optimalpayments/errors/invalid_request"
require "optimalpayments/errors/netbanx"
require "optimalpayments/errors/permission"
require "optimalpayments/errors/request_conflict"
require "optimalpayments/errors/request_declined"

module OptimalPayments
end
