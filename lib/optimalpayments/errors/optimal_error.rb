module OptimalPayments
  class OptimalError < StandardError
    attr_reader :response

    def initialize(response=nil)
      @response = response
    end
  end
end