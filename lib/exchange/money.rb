module Exchange
  class Money

    attr_reader :amount, :currency

    @@conversion_rates = {}
    @@base_currency = nil

    class << self

      def conversion_rates(base_currency, conversion_rates)
        class_variable_set(:@@base_currency, base_currency)
        class_variable_set(:@@conversion_rates, conversion_rates)
      end

    end

    def initialize(amount, currency)
      @amount = amount.to_f
      @currency = currency
    end

    def inspect
      "%.2f #{currency}" % [amount]
    end

    def ==(other)
      base_currency_amount.round(2) == other.base_currency_amount.round(2)
    end

    protected

    def base_currency_amount
      amount / current_rate
    end

    private

    def current_rate
      return 1.0 if @currency == @@base_currency
      @@conversion_rates[@currency]
    end
  end
end
