require 'spec_helper'

describe StatusCat::Checker do

  it 'has a name' do
    checker = StatusCat::Checker.new( :foobar )
    checker.name.should eql( :foobar )
  end

end