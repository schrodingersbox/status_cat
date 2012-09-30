require 'spec_helper'

describe StatusCat::Checkers::ActiveRecordChecker do

  before( :each ) do
    @checker = StatusCat::Checkers::ActiveRecordChecker.new
  end

  describe 'value' do

    it 'returns the ActiveRecord adapter, username and database' do
      expected = 'sqlite3:@db/test.sqlite3'
      @checker.value.should eql( expected )
    end

  end

  describe 'status' do

    it 'passes if it can execute a query against the database' do
      ActiveRecord::Base.connection.stub!( :execute )
      @checker.status.should be_nil
    end

    it 'returns an error message if it fails to query the database' do
      expected = 'This is only a test'
      ActiveRecord::Base.connection.should_receive( :execute ).and_raise( expected )
      @checker.status.to_s.should eql( expected )
    end

  end

end