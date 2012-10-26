require 'spec_helper'

describe StatusCat::Checkers::ActiveRecord do

  before( :each ) do
    @checker = StatusCat::Checkers::ActiveRecord.new
  end

  it_should_behave_like 'a status checker' do
    let( :checker ) { @checker }
  end

  it 'provides configuration' do
    expected = YAML::load( ERB.new( IO.read( "#{Rails.root}/config/database.yml" ) ).result )[ Rails.env ]
    @checker.config.should eql( expected )
  end

  it 'constructs a value from the configuration' do
    expected = "#{@checker.config[ 'adapter' ]}:#{@checker.config[ 'username' ]}@#{@checker.config[ 'database' ]}"
    @checker.value.should eql( expected )
  end

  describe '#status' do

    context 'pass' do

      it 'passes if it can execute a query against the database' do
        ActiveRecord::Base.connection.stub!( :execute )
        @checker = StatusCat::Checkers::ActiveRecord.new
        @checker.status.should be_nil
      end

    end

    context 'fail' do

      it 'returns an error message if it fails to query the database' do
        fail = 'This is only a test'
        ActiveRecord::Base.connection.should_receive( :execute ).and_raise( fail )
        @checker = StatusCat::Checkers::ActiveRecord.new
        @checker.status.to_s.should eql( fail )
      end

    end

  end

end