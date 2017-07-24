describe StatusCat::Checkers::Slack do

  let(:checker) { StatusCat::Checkers::Slack.new.freeze }

  it_should_behave_like 'a status checker'

  describe '#initialize' do

    it 'tolerates the gem misssing' do
      gem = Object.send(:remove_const, :Slack)
      expect(checker.status).to eql('slack-ruby-client gem is not installed')
      Object.const_set(:Slack, gem)
    end

    it 'sets the value' do
      expect(checker.value).to eql(::Slack.config.token)
    end

    context 'pass' do

      it 'passes if it can connect to Twilio' do
        expect(checker.status).to be_nil
      end
    end

    context 'fail' do

      it 'fails if it receives not ok' do
        expect(@slack_message).to receive(:ok?).and_return(false)
        expect(checker.status).to_not be_nil
      end

      it 'fails if there is an exception' do
        expect(@slack).to receive(:auth_test).and_raise('This is only a test')
        expect(checker.status).to_not be_nil
      end
    end
  end
end
