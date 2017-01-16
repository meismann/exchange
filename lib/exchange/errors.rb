module Exchange
  class UnknownCurrencyError < StandardError
    def initialize(currency)
      @currency = currency
    end

    def message
      "The currency #{@currency} is unknown."
    end

  end
end

