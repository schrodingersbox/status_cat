describe StatusCat::Checkers::SendHub do

  let(:checker) { StatusCat::Checkers::SendHub.new.freeze }

  it_should_behave_like 'a status checker'

  describe '#initialize' do

    it 'tolerates the gem misssing' do
      gem = Object.send(:remove_const, :SendHub)
      expect(checker.status).to eql('ruby-sendhub gem is not installed')
      Object.const_set(:SendHub, gem)
    end

    it 'sets the value' do
      expect(checker.value).to eql(StatusCat::Checkers::SendHub.number)
    end

    context 'pass' do

      it 'passes if it can connect to SendHub' do
        expect(checker.status).to be_nil
      end
    end

    context 'fail' do

      it 'fails if it receives nil' do
        expect(@send_hub).to receive(:get_contacts).and_return(nil)
        expect(checker.status).to_not be_nil
      end

      it 'fails if there is an exception' do
        expect(@send_hub).to receive(:get_contacts).and_raise('This is only a test')
        expect(checker.status).to_not be_nil
      end
    end
  end
end
