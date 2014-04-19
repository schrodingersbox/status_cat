require 'spec_helper'

describe StatusCat::Checkers::Base do

  let( :checker ) { StatusCat::Checkers::Base.new }

  describe '#name' do

    it 'generates a symbolized class name' do
      checker.name.should be( :base )
    end

  end

  describe 'attributes' do

    it 'has value and status readers' do
      checker.value.should be_nil
      checker.status.should be_nil
    end

  end

  describe '#to_s' do

    before( :each ) do
      checker.stub( :value ).and_return( 'secret' )
      checker.stub( :status ).and_return( 'fail' )
    end

    it 'generates a string' do
      checker.to_s.should eql( "base | secret | fail\n" )
    end

    it 'accepts a format' do
      checker.to_s( '%s * %s * %s' ).should eql( 'base * secret * fail' )
    end

  end

  describe '#fail_on_exception' do

    it 'returns an exception if raised from the block given' do
      error = 'test'
      status = checker.send( :fail_on_exception ) { raise error }
      status.to_s.should eql( error )
    end

    it 'returns the results of the block when there is no exception' do
      status = checker.send( :fail_on_exception ) { true }
      status.should be_true
    end

  end

end