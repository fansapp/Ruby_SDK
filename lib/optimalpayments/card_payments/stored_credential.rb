module OptimalPayments
  module CardPayments
    class StoredCredential < JsonObject
      attr_accessor :type
      attr_accessor :occurrence
    end
  end
end