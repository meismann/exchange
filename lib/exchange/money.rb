module Exchange
  class Money

    attr_reader :amount, :currency

    @@conversion_rates = {}
    @@base_currency = nil

    class << self

      attr_accessor :test

      def conversion_rates(base_currency, conversion_rates)
        if ( class_variable_get(:@@base_currency) && ! test )
          warn "#{self.to_s}.#{__method__} has just been initialized anew!"
        end
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

    def convert_to(other_currency)
      raise UnknownCurrencyError.new(other_currency) unless known?(other_currency)

      self.class.new(
        base_currency_amount * rate_for(other_currency),
        other_currency
      )
    end

    protected

    def base_currency_amount
      amount / current_rate
    end

    private

    def rate_for(other_currency)
      return 1.0 if other_currency == @@base_currency

      @@conversion_rates[other_currency]
    end

    def current_rate
      return 1.0 if @currency == @@base_currency
      @@conversion_rates[@currency]
    end

    def known?(_currency)
      _currency == @@base_currency || @@conversion_rates.has_key?(_currency)
    end

  end
end
