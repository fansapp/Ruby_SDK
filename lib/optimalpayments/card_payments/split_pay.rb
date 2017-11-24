module OptimalPayments
  module CardPayments
    class SplitPay < JsonObject
      attr_accessor :linkedAccount
      attr_accessor :percent
      attr_accessor :ammount
    end
  end
end
