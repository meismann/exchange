# Exchange

A small gem to perform arithmetical operations and comparisons on Money objects across different currencies

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exchange'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exchange

## Usage

Configure the currency rates with respect to a base currency (here EUR):

```ruby
Exchange::Money.conversion_rates('EUR', {
    'USD'     => 1.11,
    'Bitcoin' => 0.0047
    })
```

Instantiate money objects:

```ruby
fifty_eur = Exchange::Money.new(50, 'EUR')
```

Get amount and currency:

```ruby
fifty_eur.amount   # => 50.0
fifty_eur.currency # => "EUR"
fifty_eur.inspect  # => "50.00 EUR"
```

Returns another Exchange::Money object:
```ruby
fifty_eur.convert_to('USD') # => 55.50 USD
```

Arithmethics:

```ruby
twenty_dollars = Exchange::Money.new(20, 'USD')
fifty_eur + twenty_dollars # => 68.02 EUR
fifty_eur - twenty_dollars # => 31.98 EUR
fifty_eur / 2              # => 25 EUR
twenty_dollars * 3         # => 60 USD
```

Comparisons:
```ruby
twenty_dollars == Exchange::Money.new(20, 'USD') # => true
twenty_dollars == Exchange::Money.new(30, 'USD') # => false

fifty_eur_in_usd = fifty_eur.convert_to('USD')
fifty_eur_in_usd == fifty_eur          # => true

twenty_dollars > Exchange::Money.new(5, 'USD')   # => true
twenty_dollars < fifty_eur             # => true
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/exchange.

