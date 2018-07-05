module OptimalPayments
  module CardPayments
    class StoreCredential < JsonObject
      attr_accessor :type
      attr_accessor :occurrence
    end
  end
end