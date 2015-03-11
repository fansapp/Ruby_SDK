module OptimalPayments
  class OptimalError < StandardError
    attr_reader :message

    def initialize(message=nil)
      @message = message
    end
  end
end