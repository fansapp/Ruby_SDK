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

class HostedPaymentController < ApplicationController
  def simple
    if request.post?
      begin
        order_obj = OptimalPayments::HostedPayment::Order.new ({
          merchantRefNum: params[:merchant_ref_num],
          currencyCode: SampleRailsApp::Application.config.currency_code,
          totalAmount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units,
          redirect: [
            {
              rel: "on_success",
              uri: request.original_url,
              returnKeys: ['id']
            },
            {
              rel: "on_decline",
              uri: request.original_url,
              returnKeys: ['id']
            },
            {
              rel: "on_error",
              uri: request.original_url,
              returnKeys: ['id']
            }
          ],
          profile: {
            firstName: params[:first_name],
            lastName: params[:last_name]
          },
          billingDetails: {
            street: params[:street],
            city: params[:city],
            state: params[:state],
            country: params[:country],
            zip: params[:zip]
          }
        })
        @result = get_client.hosted_payment_service.process_order order_obj
        session[:order] = YAML::dump(@result)
        redirect_to @result.get_link("hosted_payment")[:uri]
      rescue Exception => e
        @result = e
      end
    end

    if params[:id]
      session_order = YAML::load(session[:order])
      #session[:order] = nil
      raise "No pending order found" if session_order.nil?
      raise "Invalid id" unless session_order.id == params[:id]

      order_obj = OptimalPayments::HostedPayment::Order.new({
        id: params[:id]
      })
      order = get_client.hosted_payment_service.get_order order_obj

      if order.transaction[:status] == "success"
        raise "Invalid Amount" unless session_order.totalAmount == order.transaction[:amount].to_i
        @result = "Payment Successful! ID: " + order.id
      else
        @result = order
      end
    end
  end

  def silent_card
    raise "No order exists" if session[:order].nil?
    @session_order = YAML::load(session[:order])
  end

  def silent
    if request.post?
      begin
        order_obj = OptimalPayments::HostedPayment::Order.new ({
          merchantRefNum: params[:merchant_ref_num],
          currencyCode: SampleRailsApp::Application.config.currency_code,
          totalAmount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units,
          extendedOptions: [
            { key: "silentPost", value: true }
          ],
          redirect: [
            {
              rel: "on_success",
              uri: request.original_url,
              returnKeys: ['id']
            },
            {
              rel: "on_decline",
              uri: request.original_url,
              returnKeys: ['id']
            },
            {
              rel: "on_error",
              uri: request.original_url,
              returnKeys: ['id']
            }
          ],
          profile: {
            firstName: params[:first_name],
            lastName: params[:last_name]
          },
          billingDetails: {
            street: params[:street],
            city: params[:city],
            state: params[:state],
            country: params[:country],
            zip: params[:zip]
          }
        })
        @result = get_client.hosted_payment_service.process_order order_obj
        session[:order] = YAML::dump(@result)
        redirect_to hosted_payment_silent_card_path
      rescue Exception => e
        @result = e
      end
    end

    if params[:id]
      session_order = YAML::load(session[:order])
      #session[:order] = nil
      raise "No pending order found" if session_order.nil?
      raise "Invalid id" unless session_order.id == params[:id]

      order_obj = OptimalPayments::HostedPayment::Order.new({
        id: params[:id]
      })
      order = get_client.hosted_payment_service.get_order order_obj

      if order.transaction[:status] == "success"
        raise "Invalid Amount" unless session_order.totalAmount == order.transaction[:amount].to_i
        @result = "Payment Successful! ID: " + order.id
      else
        @result = order
      end
    end
  end

  private
    def get_client
      @client ||= OptimalPayments::OptimalApiClient.new(
        SampleRailsApp::Application.config.optimal_api_key,
        SampleRailsApp::Application.config.optimal_api_secret,
        OptimalPayments::Environment::TEST,
        SampleRailsApp::Application.config.optimal_account_number
      )
    end
end
