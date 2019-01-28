module OptimalPayments
  class Environment
    TEST = "GOLO:DEV";
    QA = "OPTIMAL:TEST";
    LIVE = "NETBANX:LIVE";

    def initialize
      raise "This class should not be instantiated, use statically only."
    end
  end
end
