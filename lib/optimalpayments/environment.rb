module OptimalPayments
  class Environment
    TEST = "OPTIMAL:TEST";
    LIVE = "NETBANX:LIVE";

    def initialize
      raise "This class should not be instantiated, use statically only."
    end
  end
end