require 'spec_helper'

describe StatusCat::Config do

  let( :config ) { StatusCat::Config.instance }

  it 'is a singleton' do
    config.should be( StatusCat::Config.instance )
  end

  describe 'attributes' do

    it 'has an #enabled accessor' do
      config.enabled.should_not be_nil
      config.enabled = config.enabled
      config.enabled.should eql( config.enabled )
    end

    it 'has a #from accessor' do
      config.from.should_not be_nil
      config.from = config.from
      config.from.should eql( config.from )
    end

    it 'has a #noreply accessor' do
      config.noreply.should_not be_nil
      config.noreply = config.noreply
      config.noreply.should eql( config.noreply )
    end

    it 'has a #to accessor' do
      config.to.should_not be_nil
      config.to = config.to
      config.to.should eql( config.to )
    end

    it 'has an #subject accessor' do
      config.subject.should_not be_nil
      config.subject = config.subject
      config.subject.should eql( config.subject )
    end

  end

  describe '#initialize' do

    it 'defaults the #enabled list to all StatusCat::Checkers::Base subclasses' do
      descendants = StatusCat::Checkers::Base.descendants
      StatusCat::Checkers::Base.should_receive( :descendants ).and_return( descendants )

      config.enabled = nil
      config.send( :initialize )
      config.enabled.should_not be_nil
    end

  end

end

