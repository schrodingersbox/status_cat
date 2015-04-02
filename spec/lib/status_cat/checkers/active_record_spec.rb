describe StatusCat::Checkers::ActiveRecord do

  let( :checker ) { StatusCat::Checkers::ActiveRecord.new.freeze }

  it_should_behave_like 'a status checker'

  it 'constructs a value from the configuration' do
    config = { :adapter => 'postgres', :username => 'dba', :database => 'test' }
    expect( ::ActiveRecord::Base ).to receive( :connection_config ).and_return( config )
    expected = "#{config[ :adapter ]}:#{config[ :username ]}@#{config[ :database ]}"
    expect( checker.value ).to eql( expected )
  end

  describe '#status' do

    context 'pass' do

      it 'passes if it can execute a query against the database' do
        allow( ActiveRecord::Base.connection ).to receive( :execute )
        checker = StatusCat::Checkers::ActiveRecord.new
        expect( checker.status ).to be_nil
      end
    end

    context 'fail' do

      it 'returns an error message if it fails to query the database' do
        fail = 'This is only a test'
        expect( ActiveRecord::Base.connection ).to receive( :execute ).and_raise( fail )
        checker = StatusCat::Checkers::ActiveRecord.new
        expect( checker.status.to_s ).to eql( fail )
      end
    end
  end
end