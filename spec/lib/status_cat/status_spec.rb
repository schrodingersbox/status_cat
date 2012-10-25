require 'spec_helper'

describe StatusCat::Status do

  it 'returns a list of all Checkers' do
    all = StatusCat::Status.all
    all.should be_an_instance_of( Array )
    all.length.should > 0
    all.each { |checker| checker.should be_a_kind_of( StatusCat::Checkers::Base ) }
  end


end

