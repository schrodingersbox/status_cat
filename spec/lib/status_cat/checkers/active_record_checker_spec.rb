require 'spec_helper'

describe StatusCat::Checkers::ActiveRecordChecker do

  before( :each ) do
    @checker = StatusCat::Checkers::ActiveRecordChecker.new
    @value = "#{@checker.config[ 'adapter' ]}:#{@checker.config[ 'username' ]}@#{@checker.config[ 'database' ]}"
    @fail = 'This is only a test'
  end

  context 'instance' do

    it 'inherits from StatusCat::Checker' do
      @checker.should be_a_kind_of( StatusCat::Checker )
    end

    it 'has a name, value, and status accessor' do
      @checker.name.should be( :active_record )
      @checker.value.should eql( @value )
      @checker.status.should be_nil
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

end