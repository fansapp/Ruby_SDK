module OptimalPayments
  class CustomerVaultService
    def initialize client
      @client = client # OptimalApiClient
      @uri = "/customervault/v1" # URI for hosted payment API
    end

    def monitor
      request = Request.new({
        method: Request::GET,
        uri: "/customervault/monitor"
      })
      @client.process_request(request)[:status] == "READY"
    end

    def create_singleUseToken profile
      puts "----------coming in create_singleUseToken"
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/singleusetokens"),
        body: profile.get(
            required = ['card']
          )
      )

      @client.process_request request
    end  

    ###########
    # Profile
    ###########

    def create_profile profile
      puts "!!!!!!!!!!!coming in create_profile"
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/profiles"),
        body: profile.get(
            required = ['merchantCustomerId', 'locale', 'singleUseToken']
            #required = ['merchantCustomerId', 'locale']
          )
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    def get_profile profile, addresses=false, cards=false
      fields = []
      fields << "addresses" if addresses
      fields << "cards" if cards

      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/profiles/" + profile.id),
        query: fields.length ? { fields: fields.join(",") } : {}
      )

      response = @client.process_request request
      CustomerVault::Profile::new response
    end

    def update_profile profile
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/profiles/" + profile.id),
        body: profile.get(
            required = ['merchantCustomerId', 'locale'],
            ignore = ['id']
          )
      )

      @client.process_request request
      true
    end

    def delete_profile profile
      request = Request.new(
        method: Request::DELETE,
        uri: prepare_uri("/profiles/" + profile.id)
      )

      @client.process_request request
      true
    end

    ###########
    # Cards
    ###########

    def get_card card
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id)
      )

      response = @client.process_request request
      response[:profileID] = card.profileID

      CustomerVault::Card::new response
    end

    def create_card card
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/profiles/" + card.profileID + "/cards"),
        body: card.get(
            required = ['cardNum', 'cardExpiry'],
            ignore = ['profileID']
          )
      )

      response = @client.process_request request
      CustomerVault::Card::new response
    end

    def update_card card
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id),
        body: card.get(
            required = [],
            ignore = ['profileID', 'id']
          )
      )

      response = @client.process_request request
      response[:profileID] = card.profileID

      CustomerVault::Card::new response
    end

    def delete_card card
      request = Request.new(
        method: Request::DELETE,
        uri: prepare_uri("/profiles/" + card.profileID + "/cards/" + card.id)
      )

      @client.process_request request
      true
    end

    ###########
    # Addresses
    ###########

    def create_address address
      request = Request.new(
        method: Request::POST,
        uri: prepare_uri("/profiles/" + address.profileID + "/addresses"),
        body: address.get(
            required = ['country'],
            ignore = ['profileID']
          )
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      CustomerVault::Address::new response
    end

    def update_address address
      request = Request.new(
        method: Request::PUT,
        uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id),
        body: address.get(
            required = ['country'],
            ignore = ['profileID', 'id']
          )
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      address_obj = CustomerVault::Address::new response
    end

    def delete_address address
      request = Request.new(
        method: Request::DELETE,
        uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id)
      )

      @client.process_request request
      true
    end

    def get_address address
      request = Request.new(
        method: Request::GET,
        uri: prepare_uri("/profiles/" + address.profileID + "/addresses/" + address.id)
      )

      response = @client.process_request request
      response[:profileID] = address.profileID

      CustomerVault::Address::new response
    end
    private
      # Prepare URI for submission to the API
      def prepare_uri path
        "#{@uri}#{path}"
      end
  end
end