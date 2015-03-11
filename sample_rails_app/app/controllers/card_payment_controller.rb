require "securerandom"
require "optimalpayments"
require "yaml"

class CardPaymentController < ApplicationController
  def simple
    if request.post?
      begin
        auth_obj = OptimalPayments::CardPayments::Authorization.new ({
          merchantRefNum: params[:merchant_ref_num],
          amount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units,
          settleWithAuth: true,
          card: {
            cardNum: params[:card_number],
            cvv: params[:card_cvv],
            cardExpiry: {
              month: params[:date][:month],
              year: params[:date][:year]
            }
          },
          billingDetails: {
            street: params[:street],
            city: params[:city],
            state: params[:state],
            country: params[:country],
            zip: params[:zip]
          }
        })
        @result = get_client.card_payment_service.authorize auth_obj
      rescue Exception => e
        @result = e
      end
    end
  end

  def customer_vault
    if request.post?
      begin
        profile_obj = OptimalPayments::CustomerVault::Profile.new({
          merchantCustomerId: params[:merchant_customer_num],
          locale: "en_US",
          firstName: params[:first_name],
          lastName: params[:last_name],
          email: params[:email]
        })
        profile = get_client.customer_vault_service.create_profile profile_obj

        address = OptimalPayments::CustomerVault::Address.new({
          nickName: "home",
          street: params[:street],
          city: params[:city],
          country: params[:country],
          state: params[:state],
          zip: params[:zip],
          profileID: profile.id
        })
        address = get_client.customer_vault_service.create_address address

        card_obj = OptimalPayments::CustomerVault::Card.new({
          nickName: "Default Card",
          cardNum: params[:card_number],
          #cvv: params[:card_cvv],
          cardExpiry: {
            month: params[:date][:month],
            year: params[:date][:year]
          },
          billingAddressId: address.id,
          profileID: profile.id
        })
        card = get_client.customer_vault_service.create_card card_obj

        auth_obj = OptimalPayments::CardPayments::Authorization.new ({
          merchantRefNum: params[:merchant_ref_num],
          amount: params[:amount].to_i * SampleRailsApp::Application.config.currency_base_units,
          settleWithAuth: true,
          card: {
            paymentToken: card.paymentToken
          }
        })
        @result = get_client.card_payment_service.authorize auth_obj
      rescue Exception => e
        @result = e
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
