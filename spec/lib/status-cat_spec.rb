require 'spec_helper'

describe StatusCat do

  describe '::config' do

    it 'returns the configuration' do
      StatusCat.config.should be( StatusCat::Config.instance )
    end

  end

  describe '::configure' do

    it 'yields the configuration' do
      StatusCat.configure { |config| config.should be( StatusCat::Config.instance ) }
    end

  end

end