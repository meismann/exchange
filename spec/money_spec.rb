RSpec.describe Exchange::Money do

  before do
    Exchange::Money.test = true
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

  describe '#==' do
    it 'returns true when two Money are of the same value' do
      expect(subject == Exchange::Money.new(55.5, 'USD')).to be true
    end
  end

  describe '#<' do
    it "returns true when self's amount is smaller than other's" do
      expect(subject < subject * 2).to be true
    end

    it "returns false when self's amount is greater than other's" do
      expect(subject < subject / 2).to be false
    end

    it "returns false when self's amount is equal to other's" do
      expect(subject < subject.clone).to be false
    end
  end

  describe '#convert_to' do
    it 'converts Money according to conversion rates' do
      expect(subject.convert_to('USD')).to eq Exchange::Money.new(55.5, 'USD')
    end

    it 'converts Money object to its own currency without error' do
      expect(subject.convert_to('EUR')).to eq Exchange::Money.new(50.0, 'EUR')
    end

    it 'raises an error if given an unknown currency' do
      expect{ subject.convert_to('XXX') }.to raise_error(
        Exchange::UnknownCurrencyError, /XXX/
      )
    end
  end

  describe '#+' do
    let(:other) { Exchange::Money.new 22.2, 'USD' }
    it "returns a new Money object, summing up self's and other's value" do
      expect(subject + other).to eq Exchange::Money.new(70.0, 'EUR')
    end

    it "preserves self's currency" do
      subject2 = Exchange::Money.new 5, 'Bitcoin'
      expect((subject2 + other).currency).to eq 'Bitcoin'
    end
  end

  describe '#-' do
    let(:other) { Exchange::Money.new 22.2, 'USD' }
    it "returns a new Money object, substracting other's from self's value" do
      expect(subject - other).to eq Exchange::Money.new(30.0, 'EUR')
    end
  end

  describe '#/' do
    it "returns a new Money object, dividing self's value by argument" do
      expect(subject / 4).to eq Exchange::Money.new(12.5, 'EUR')
    end
  end

  describe '#*' do
    it "returns a new Money object, multiplying self's value by argument" do
      expect(subject * 1.25).to eq Exchange::Money.new(62.5, 'EUR')
    end
  end

end
