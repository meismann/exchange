module Exchange
  class Money

    attr_reader :amount

    class << self

      def conversion_rates(base_currency, conversion_rates)
      end

    end

    def initialize(amount, currency)
      @amount = amount.to_f
    end

  end
end
