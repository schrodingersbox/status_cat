describe StatusCat::Checkers::ActionMailer do

  let(:checker) { StatusCat::Checkers::ActionMailer.new.freeze }

  it_should_behave_like 'a status checker'

  it 'provides configuration' do
    expect(checker.config).to eql(::ActionMailer::Base.smtp_settings)
  end

  it 'constructs a value from the configuration' do
    expected = "#{checker.address}:#{checker.port}"
    expect(checker.value).to eql(expected)
  end

  #############################################################################
  # status

  describe '#status' do

    before(:each) do
      ::ActionMailer::Base.delivery_method = :smtp
    end

    after(:each) do
      ::ActionMailer::Base.delivery_method = :test
    end

    #############################################################################
    # pass

    context 'pass' do

      it 'passes if it can make an SMTP connection' do
        expect(Net::SMTP).to receive(:start)
        checker = StatusCat::Checkers::ActionMailer.new
        expect(checker.status).to be_nil
      end
    end

    #############################################################################
    # fail

    context 'fail' do

      let(:exception) { Net::SMTPAuthenticationError.new }

      it 'returns an error message if it can not make an SMTP connection' do
        expect(Net::SMTP).to receive(:start).and_raise(exception)
        checker = StatusCat::Checkers::ActionMailer.new
        expect(checker.status).to be(exception)
      end

      it 'returns an error message if it can not send a message' do
        smtp = Object.new
        allow(smtp).to receive(:helo).and_raise(exception)
        allow(Net::SMTP).to receive(:start).and_yield(smtp)
        checker = StatusCat::Checkers::ActionMailer.new
        expect(checker.status).to be(exception)
      end
    end
  end
end
