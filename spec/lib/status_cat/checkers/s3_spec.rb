require 'spec_helper'

describe StatusCat::Checkers::S3 do

  let( :checker ) { StatusCat::Checkers::S3.new.freeze }

  before( :each ) do

  end

  it_should_behave_like 'a status checker'

  it 'should be specced better'

end