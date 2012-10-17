require 'spec_helper'

describe StatusCat::Checkers::ActionMailerChecker do

  before( :each ) do
    @checker = StatusCat::Checkers::ActionMailerChecker.new
    @value = "#{@checker.config[ :address ]}:#{@checker.config[ :port ]}"
    @fail = 'This is only a test'
  end

  context 'instance' do

    it 'inherits from StatusCat::Checker' do
      @checker.should be_a_kind_of( StatusCat::Checker )
    end

    it 'has a name, value, and status accessor' do
      @checker.name.should be( :action_mailer )
      @checker.value.should eql( @value )
      @checker.status.should be_nil
    end

    it 'provides configuration' do
      @checker.config.should eql( ActionMailer::Base.smtp_settings )
    end

    describe 'status' do

      before( :each ) do
        ActionMailer::Base.delivery_method = :smtp
        ActionMailer::Base.smtp_settings  = {
            :address => 'smtp.sendgrid.net',
            :port => '587'
          }
      end

      after( :each ) do
        ActionMailer::Base.delivery_method = :test
      end

      context 'pass' do

        it 'passes if it can make an SMTP connection' do
          Net::SMTP.should_receive( :start )
          @checker = StatusCat::Checkers::ActionMailerChecker.new
          @checker.status.should be_nil
        end

      end

      context 'fail' do

        it 'returns an error message if it can not make an SMTP connection' do
          Net::SMTP.should_receive( :start ).and_raise( @fail )
          @checker = StatusCat::Checkers::ActionMailerChecker.new
          @checker.status.to_s.should eql( @fail )
        end

      end

    end

  end

end