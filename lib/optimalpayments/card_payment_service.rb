module OptimalPayments
  class CardPaymentService
    def initialize client
      @client = client # OptimalApiClient
      @uri = "/cardpayments/v1" # URI for hosted payment API
    end

    def monitor
      request = Request.new({
        method: Request::GET,
        uri: "/cardpayments/monitor"
      })
      @client.process_request(request)[:status] == "READY"
    end

    ###########
    # Auths
    ###########

    def authorize auth
      request = Request.new({
        method: Request::POST,
        uri: prepare_uri("/auths"),
        body: auth.get(
            required = ['merchantRefNum', 'amount', 'card']
          )
      })
      response = @client.process_request request
      CardPayments::Authorization::new response
    end

    def get_auth auth
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/auths/" + auth.id.to_s)
      })
      response = @client.process_request request
      CardPayments::Authorization::new response
    end

    def get_auths auth=nil, filter=nil
      query_str = filter == nil ? {} : filter.to_h
      query_str[:merchantRefNum] = auth.merchantRefNum if auth.merchantRefNum
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/auths/"),
        query: query_str
      })
      response = @client.process_request request
      Pagerator::new response, @client, CardPayments::Authorization
    end

    def get_auth_reversal auth
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/voidauths/" + auth.id)
      })
      response = @client.process_request request
      CardPayments::Authorization::new response
    end

    def get_auth_reversals auth=nil, filter=nil
      query_str = filter == nil ? {} : filter.to_h
      query_str[:merchantRefNum] = auth.merchantRefNum if auth.merchantRefNum
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/voidauths"),
        query: query_str
      })
      response = @client.process_request request
      Pagerator::new response, @client, CardPayments::AuthorizationReversal
    end

    def cancel_held_auth auth
      tmp_auth = CardPayments::Authorization.new({
        status: "CANCELLED"
      })
      request = Request.new({
        method: Request::PUT,
        uri: prepare_uri("/auths/" + auth.id),
        body: tmp_auth.get
      })

      response = @client.process_request request
      CardPayments::Authorization::new response
    end

    def approve_held_auth auth
      tmp_auth = CardPayments::Authorization.new({
        status: "COMPLETED"
      })
      request = Request.new({
        method: Request::PUT,
        uri: prepare_uri("/auths/" + auth.id),
        body: tmp_auth.get
      })
      response = @client.process_request request
      CardPayments::Authorization::new response
    end

    def reverse_auth auth
      request = Request.new({
        method: Request::POST,
        uri: prepare_uri("/auths/" + auth.authorizationID + "/voidauths"),
        body: auth.get(
            required = ['amount', 'dupCheck'],
            ignore = ['authorizationID']
          )
      })
      response = @client.process_request request
      CardPayments::AuthorizationReversal::new response
    end

    ###########
    # Settlements
    ###########

    def settlement settlement
      request = Request.new({
        method: Request::POST,
        uri: prepare_uri("/auths/" + settlement.authorizationID + "/settlements"),
        body: settlement.get(
            required = ['amount', 'dupCheck'],
            ignore = ['authorizationID']
          )
      })
      response = @client.process_request request
      CardPayments::Settlement::new response
    end

    def get_settlement settlement
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/settlements/" + settlement.id)
      })
      response = @client.process_request request
      CardPayments::Settlement::new response
    end

    def get_settlements settlement=nil, filter=nil
      query_str = filter == nil ? {} : filter.to_h
      query_str[:merchantRefNum] = settlement.merchantRefNum if settlement.merchantRefNum
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/settlements"),
        query: query_str
      })
      response = @client.process_request request
      Pagerator::new response, @client, CardPayments::Settlement
    end

    def cancel_settlement settlement
      tmp_settlement = CardPayments::Settlement.new({
        status: "CANCELLED"
      })
      request = Request.new({
        method: Request::PUT,
        uri: prepare_uri("/settlements/" + settlement.id),
        body: tmp_settlement.get
      })
      response = @client.process_request request
      CardPayments::Settlement::new response
    end

    ###########
    # Refunds
    ###########

    def refund refund
      request = Request.new({
        method: Request::POST,
        uri: prepare_uri("/settlements/" + refund.settlementID + "/refunds"),
        body: refund.get(
            required = ['amount', 'dupCheck'],
            ignore = ['settlementID']
          )
      })
      response = @client.process_request request
      CardPayments::Refund::new response
    end

    def get_refund refund
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/refunds/" + refund.id)
      })
      response = @client.process_request request
      CardPayments::Refund::new response
    end

    def get_refunds refund=nil, filter=nil
      query_str = filter == nil ? {} : filter.to_h
      query_str[:merchantRefNum] = refund.merchantRefNum if refund.merchantRefNum
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/refunds"),
        query: query_str
      })
      response = @client.process_request request
      Pagerator::new response, @client, CardPayments::Refund
    end

    def cancel_refund refund
      tmp_refund = CardPayments::Refund.new({
        status: "CANCELLED"
      })
      request = Request.new({
        method: Request::PUT,
        uri: prepare_uri("/refunds/" + refund.id),
        body: tmp_refund.get
      })
      response = @client.process_request request
      CardPayments::Refund::new response
    end

    ###########
    # Verify
    ###########

    def verify verify
      request = Request.new({
        method: Request::POST,
        uri: prepare_uri("/verifications"),
        body: verify.get(
            required = ['merchantRefNum', 'card']
          )
      })
      response = @client.process_request request
      CardPayments::Verification::new response
    end

    def get_verification verify
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/verifications/" + verify.id)
      })
      response = @client.process_request request
      CardPayments::Verification::new response
    end

    def get_verifications verify=nil, filter=nil
      query_str = filter == nil ? {} : filter.to_h
      query_str[:merchantRefNum] = verify.merchantRefNum if verify.merchantRefNum
      request = Request.new({
        method: Request::GET,
        uri: prepare_uri("/verifications"),
        query: query_str
      })
      response = @client.process_request request
      Pagerator::new response, @client, CardPayments::Verification
    end

    private
      # Prepare URI for submission to the API
      def prepare_uri path
        "#{@uri}/accounts/#{@client.account}#{path}"
      end
  end
end