require 'spec_helper'

describe StatusCat::Checkers::ActionMailer do

  let( :checker ) { StatusCat::Checkers::ActionMailer.new.freeze }

  it_should_behave_like 'a status checker'

  it 'provides configuration' do
    checker.config.should eql( ::ActionMailer::Base.smtp_settings )
  end

  it 'constructs a value from the configuration' do
    expected = "#{checker.config[ :address ]}:#{checker.config[ :port ]}"
    checker.value.should eql( expected )
  end

  #############################################################################
  # status
  #############################################################################

  describe '#status' do

    before( :each ) do
      ::ActionMailer::Base.delivery_method = :smtp
    end

    after( :each ) do
      ::ActionMailer::Base.delivery_method = :test
    end

    #############################################################################
    # pass
    #############################################################################

    context 'pass' do

      it 'passes if it can make an SMTP connection' do
        Net::SMTP.should_receive( :start )
        checker = StatusCat::Checkers::ActionMailer.new
        checker.status.should be_nil
      end

    end

    #############################################################################
    # fail
    #############################################################################

    context 'fail' do

      let( :exception ) { Net::SMTPAuthenticationError.new }

      it 'returns an error message if it can not make an SMTP connection' do
        Net::SMTP.should_receive( :start ).and_raise( exception )
        checker = StatusCat::Checkers::ActionMailer.new
        checker.status.should be( exception )
      end

      it 'returns an error message if it can not send a message' do
        smtp = Object.new
        smtp.stub!( :send_message ).and_raise( exception )
        Net::SMTP.should_receive( :start ).and_yield( smtp )
        checker = StatusCat::Checkers::ActionMailer.new
        checker.status.should be( exception )
      end

    end

  end

end