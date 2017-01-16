module Exchange
  class Money

    attr_reader :amount, :currency

    class << self

      def conversion_rates(base_currency, conversion_rates)
      end

    end

    def initialize(amount, currency)
      @amount = amount.to_f
      @currency = currency
    end

    def inspect
      "%.2f #{currency}" % [amount]
    end

  end
end
