describe StatusCat::Checkers::Base do

  let(:checker) { StatusCat::Checkers::Base.new }

  describe '#name' do

    it 'generates a symbolized class name' do
      expect(checker.name).to be(:base)
    end
  end

  describe 'attributes' do

    it 'has value and status readers' do
      expect(checker.value).to be_nil
      expect(checker.status).to be_nil
    end
  end

  describe '#to_s' do

    before(:each) do
      allow(checker).to receive(:value).and_return('secret')
      allow(checker).to receive(:status).and_return('fail')
    end

    it 'generates a string' do
      expect(checker.to_s).to eql("base | secret | fail\n")
    end

    it 'accepts a format' do
      expect(checker.to_s('%s * %s * %s')).to eql('base * secret * fail')
    end
  end

  describe '#fail_on_exception' do

    it 'returns an exception if raised from the block given' do
      error = 'test'
      status = checker.send(:fail_on_exception) { raise error }
      expect(status.to_s).to eql(error)
    end

    it 'returns the results of the block when there is no exception' do
      status = checker.send(:fail_on_exception) { true }
      expect(status).to be(true)
    end
  end
end
