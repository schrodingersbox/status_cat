require 'spec_helper'

describe StatusCat::Checkers::Base do

  before( :each ) do
    @checker = StatusCat::Checkers::Base.new
  end

  it 'generates a symbolized class name' do
    @checker.name.should be( :base )
  end

  it 'has a value and status accessor' do
    @checker.value.should be_nil
    @checker.status.should be_nil
  end

  describe 'fail_on_exception' do

    it 'returns an exception if raised from the block given' do
      error = 'test'
      status = @checker.send( :fail_on_exception ) { raise error }
      status.to_s.should eql( error )
    end

    it 'returns nil when there is no exception' do
      status = @checker.send( :fail_on_exception ) { true }
      status.should be_nil
    end

  end

end