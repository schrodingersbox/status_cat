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

  describe '#status' do

    before( :each ) do
      ::ActionMailer::Base.delivery_method = :smtp
    end

    after( :each ) do
      ::ActionMailer::Base.delivery_method = :test
    end

    context 'pass' do

      it 'passes if it can make an SMTP connection' do
        Net::SMTP.should_receive( :start )
        checker = StatusCat::Checkers::ActionMailer.new
        checker.status.should be_nil
      end

    end

    context 'fail' do

      it 'returns an error message if it can not make an SMTP connection' do
        fail = 'This is only a test'
        Net::SMTP.should_receive( :start ).and_raise( fail )
        checker = StatusCat::Checkers::ActionMailer.new
        checker.status.to_s.should eql( fail )
      end

    end

  end

end