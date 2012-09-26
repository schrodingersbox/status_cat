require 'spec_helper'

describe 'version' do

  it 'has a version constant' do
    StatusCat::VERSION.should_not be_nil
    StatusCat::VERSION.should be_an_instance_of( String )
    StatusCat::VERSION.should =~ /\d+\.\d+\.\d+/
  end

end