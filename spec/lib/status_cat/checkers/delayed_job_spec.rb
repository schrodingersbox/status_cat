require 'spec_helper'

describe StatusCat::Checkers::DelayedJob do

  let( :checker ) { StatusCat::Checkers::DelayedJob.new.freeze }

  before( :each ) do

  end

  it_should_behave_like 'a status checker'

  it 'should be specced better'

end