require 'spec_helper'

describe StatusCat::Checkers::ActiveRecordChecker do

  before( :each ) do
    @checker = StatusCat::Checkers::ActiveRecordChecker.new
    @value = "#{@checker.config[ 'adapter' ]}:#{@checker.config[ 'username' ]}@#{@checker.config[ 'database' ]}"
    @fail = 'This is only a test'
  end

  it_should_behave_like 'a StatusCat::Checker' do
    let( :checker ) { @checker }
  end

  describe 'status' do

    context 'pass' do

      it 'passes if it can execute a query against the database' do
        ActiveRecord::Base.connection.stub!( :execute )
        @checker = StatusCat::Checkers::ActiveRecordChecker.new
        @checker.status.should be_nil
      end

    end

    context 'fail' do

      it 'returns an error message if it fails to query the database' do
        ActiveRecord::Base.connection.should_receive( :execute ).and_raise( @fail )
        @checker = StatusCat::Checkers::ActiveRecordChecker.new
        @checker.status.to_s.should eql( @fail )
      end

    end

  end

end