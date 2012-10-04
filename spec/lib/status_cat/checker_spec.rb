require 'spec_helper'

describe StatusCat::Checker do

  before( :each ) do
    @checker = StatusCat::Checker.new
  end

  describe 'all' do

    it 'returns a list of Checkers' do
      all = StatusCat::Checker.all
      all.should be_an_instance_of( Array )
      all.length.should > 0
      all.each { |checker| checker.should be_a_kind_of( StatusCat::Checker ) }
    end

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