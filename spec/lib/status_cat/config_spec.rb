require 'spec_helper'

describe StatusCat::Config do

  before( :all ) do
    @config = StatusCat::Config.instance
  end

  it 'is a singleton' do
    @config.should be( StatusCat::Config.instance )
  end

  describe 'attributes' do

    it 'has an email_from accessor' do
      from = 'from@schrodingersbox.com'
      @config.email_from = from
      @config.email_from.should eql( from )
    end

    it 'has an email_to accessor' do
      to = 'to@schrodingersbox.com'
      @config.email_to = to
      @config.email_to.should eql( to )
    end

    it 'has an email_subject accessor' do
      subject = 'This is only a test'
      @config.email_subject = subject
      @config.email_subject.should eql( subject )
    end

  end

end

