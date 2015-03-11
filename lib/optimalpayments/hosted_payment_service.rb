module OptimalPayments
  class HostedPaymentService
    def initialize client
      @client = client # OptimalApiClient
      @uri = "/hosted/v1" # URI for hosted payment API
    end

    def process_order order
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/orders"),
        body: order.get(
            required = ['merchantRefNum', 'currencyCode', 'totalAmount']
          )
      )

      response = @client.process_request request
      HostedPayment::Order::new response
    end

    def get_order order
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/orders/" + order.id)
      )

      response = @client.process_request request
      HostedPayment::Order::new response
    end

    def get_orders count
      raise OptimalError, "Invalid count. Positive integer expected." unless count.is_a? Numeric and count >= 0
      query_str = count > 0 ? { num: count } : {}

      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/orders"),
        query: query_str
      )

      response = @client.process_request request
      Pagerator.new response, @client, HostedPayment::Order
    end

    def cancel_order order
      request = Request.new(
        method: Request::DELETE,
        uri: prepare_uri("/orders/" + order.id)
      )
      response = @client.process_request request
      HostedPayment::Order.new response
    end

    def resend_callback order
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/orders/" + order.id + "/resend_callback")
      )
      @client.process_request request
      true
    end

    def refund refund
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/orders/" + refund.orderID + "/refund"),
        body: refund.get(
            required = ['merchantRefNum', 'amount'],
            ignore = ['orderID']
          )
      )
      response = @client.process_request request
      HostedPayment::Refund.new response
    end

    def settlement settlement
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/orders/" + settlement.orderID + "/settlement"),
        body: settlement.get(
            required = ['merchantRefNum', 'amount'],
            ignore = ['orderID']
          )
      )
      response = @client.process_request request
      HostedPayment::Refund::new response
    end

    def rebill_order order
      if order.id.nil?
        if order.profile.nil?
          throw OptimalError, "You must specify a profile or id"
        elsif not order.profile.has_key?(:id) or not order.profile.has_key?(:paymentToken)
          throw OptimalError, "You must specify a profile id and profile paymentToken"
        end
      end

      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/orders" + (order.id.nil? ? "" : "/#{order.id}")),
        body: order.get(
            required = ['merchantRefNum', 'currencyCode', 'totalAmount'],
            ignore = ['id']
          )
      )
      response = @client.process_request request
      HostedPayment::Order::new response
    end

    def update_rebill order
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/orders/" + order.id),
        body: order.get(
            required = [],
            ignore = ['id']
          )
      )
      response = @client.process_request request
      HostedPayment::Order::new response
    end

    private
      # Prepare URI for submission to the API
      def prepare_uri path
        "#{@uri}#{path}"
      end
  end
end