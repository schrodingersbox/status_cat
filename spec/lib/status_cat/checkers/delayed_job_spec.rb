require 'delayed_job_active_record'

describe StatusCat::Checkers::DelayedJob do

  let( :checker ) { StatusCat::Checkers::DelayedJob.new.freeze }

  it_should_behave_like 'a status checker'

  it 'tolerates Delayed::Job being undefined' do
    dj = Object.send(:remove_const, :Delayed)
    expect( checker.status ).to_not be_nil
    Object.const_set( :Delayed, dj )
  end

  it 'fails if there is an exception' do
    expect( ActiveRecord::Base.connection ).to receive( :execute ).and_raise( :error )
    expect( checker.status ).to_not be_nil
  end

  it 'fails if there are expired jobs' do
    expect( ActiveRecord::Base.connection ).to receive( :execute ).and_return( [1], [1] )
    expect( checker.status ).to_not be_nil
  end

  it 'passes if there are no expired jobs' do
    expect( ActiveRecord::Base.connection ).to receive( :execute ).and_return( [1], [0] )
    expect( checker.status ).to be_nil
  end

  it 'uses the job count as the value' do
    expect( ActiveRecord::Base.connection ).to receive( :execute ).and_return( [1], [0] )
    expect( checker.value ).to eql( 1 )
  end
end