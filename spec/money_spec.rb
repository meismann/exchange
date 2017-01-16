RSpec.describe Exchange::Money do

  before do
    Exchange::Money.conversion_rates('EUR', {
        'USD'     => 1.11,
        'Bitcoin' => 0.0047
    })
  end

  describe '.new' do
    it 'returns an instance of Money' do
      expect(Exchange::Money.new(3, 'EUR')).to be_an_instance_of(Exchange::Money)
    end
  end

  subject { Exchange::Money.new 50, 'EUR' }

  describe '#amount' do
    it 'returns amount (as Float)' do
      expect(subject.amount).to be 50.0
    end
  end

  describe '#currency' do
    it 'returns currency' do
      expect(subject.currency).to eq 'EUR'
    end
  end

  describe '#inspect' do
    it 'returns a String formatted like "50.00 EUR"' do
      expect(subject.inspect).to eq '50.00 EUR'
    end
  end
end
