RSpec.describe Exchange::Money do

  describe '.new' do
    it 'returns an instance of Money' do
      expect(Exchange::Money.new(3, 'EUR')).to be_an_instance_of(Exchange::Money)
    end
  end

end
