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

    def convert_to(other_currency)
      raise UnknownCurrencyError.new(other_currency) unless known?(other_currency)

      self.class.new(
        base_currency_amount * rate_for(other_currency),
        other_currency
      )
    end

    # Comparisons

    def ==(other)
      compare_amount_with other do |a, b|
        a.round(2) == b.round(2)
      end
    end

    def <(other)
      compare_amount_with other, &:<
    end

    # Arithmetics

    def +(other)
      recalc_amount_with other.convert_to(@@base_currency).amount, &:+
    end

    def -(other)
      recalc_amount_with other.convert_to(@@base_currency).amount, &:-
    end

    def /(number)
      recalc_amount_with number, &:/
    end

    def *(number)
      recalc_amount_with number, &:*
    end

    private

    def recalc_amount_with(amount_in_base_currency_or_number)
      self.class.new(
        yield(base_currency_amount, amount_in_base_currency_or_number),
        @@base_currency
      ).convert_to(currency)
    end

    def compare_amount_with(other)
      yield(base_currency_amount, other.convert_to(@@base_currency).amount)
    end

    def base_currency_amount
      amount / current_rate
    end

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
