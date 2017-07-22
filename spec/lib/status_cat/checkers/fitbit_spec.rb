describe StatusCat::Checkers::Fitbit do

  let(:checker) { StatusCat::Checkers::Fitbit.new.freeze }

  it_should_behave_like 'a status checker'

  describe '#initialize' do

    it 'tolerates the gem missing' do
      gem = Object.send(:remove_const, :Fitgem)
      expect(checker.status).to eql('fitgem gem is not installed')
      Object.const_set(:Fitgem, gem)
    end

    it 'sets the value' do
      expect(checker.value).to eql(StatusCat::Checkers::Fitbit.consumer_key)
    end

    context 'pass' do

      it 'passes if it can connect to Fitbit' do
        expect(checker.status).to be_nil
      end
    end

    context 'fail' do

      it 'fails if it receives errors' do
        expect(@fitgem).to receive(:user_info).and_return('errors' => 'this is only a test')
        expect(checker.status).to_not be_nil
      end

      it 'fails if there is an exception' do
        expect(@fitgem).to receive(:user_info).and_raise('This is only a test')
        expect(checker.status).to_not be_nil
      end
    end
  end
end
