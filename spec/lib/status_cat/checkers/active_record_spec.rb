require 'spec_helper'

describe StatusCat::Checkers::ActiveRecord do

  let( :checker ) { StatusCat::Checkers::ActiveRecord.new.freeze }

  it_should_behave_like 'a status checker'

  it 'constructs a value from the configuration' do
    config = { :adapter => 'postgres', :username => 'dba', :database => 'test' }
    expect( ::ActiveRecord::Base ).to receive( :connection_config ).and_return( config )
    expected = "#{config[ :adapter ]}:#{config[ :username ]}@#{config[ :database ]}"
    checker.value.should eql( expected )
  end

  describe '#status' do

    context 'pass' do

      it 'passes if it can execute a query against the database' do
        ActiveRecord::Base.connection.stub( :execute )
        checker = StatusCat::Checkers::ActiveRecord.new
        checker.status.should be_nil
      end

    end

    context 'fail' do

      it 'returns an error message if it fails to query the database' do
        fail = 'This is only a test'
        ActiveRecord::Base.connection.should_receive( :execute ).and_raise( fail )
        checker = StatusCat::Checkers::ActiveRecord.new
        checker.status.to_s.should eql( fail )
      end

    end

  end

end