require 'spec_helper'

describe StatusCat::Config do

  let( :config ) { StatusCat::Config.instance }

  it 'is a singleton' do
    config.should be( StatusCat::Config.instance )
  end

  describe 'attributes' do

    it 'has a #from accessor' do
      config.from.should_not be_nil
      config.from = config.from
      config.from.should eql( config.from )
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

end

