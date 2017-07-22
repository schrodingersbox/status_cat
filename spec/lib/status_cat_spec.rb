describe StatusCat do

  describe '::config' do

    it 'returns the configuration' do
      expect(StatusCat.config).to be(StatusCat::Config.instance)
    end
  end

  describe '::configure' do

    it 'yields the configuration' do
      StatusCat.configure { |config| expect(config).to be(StatusCat::Config.instance) }
    end
  end
end
