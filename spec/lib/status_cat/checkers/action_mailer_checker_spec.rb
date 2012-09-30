require 'spec_helper'

describe StatusCat::Checkers::ActionMailerChecker do

  before( :each ) do
    @checker = StatusCat::Checkers::ActionMailerChecker.new

    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings  = {
        :address => 'smtp.sendgrid.net',
        :port => '587'
      }
  end

  after( :each ) do
    ActionMailer::Base.delivery_method = :test
  end

  describe 'value' do

    it 'returns the ActionMailer SMTP address and port' do
      expected = 'smtp.sendgrid.net:587'
      @checker.value.should eql( expected )
    end

  end

  describe 'status' do

    it 'always passes for the test delivery method' do
      ActionMailer::Base.delivery_method = :test
      @checker.should_not_receive( :fail_on_exception )
      @checker.status.should be_nil
    end

    it 'passes if it can make an SMTP connection' do
      Net::SMTP.should_receive( :start )
      @checker.status.should be_nil
    end

    it 'returns an error message if it can not make an SMTP connection' do
      expected = 'This is only a test'
      Net::SMTP.should_receive( :start ).and_raise( expected )
      @checker.status.to_s.should eql( expected )
    end

  end

end