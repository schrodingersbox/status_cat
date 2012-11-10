require 'spec_helper'
require 'rake'

describe 'status-cat rake tasks' do

  before( :each ) do
    @rake = Rake::Application.new
    Rake.application = @rake
    Rake::Task.define_task(:environment)
    load 'lib/tasks/status-cat.rake'
  end

  describe 'rake status-cat:check' do

    it 'puts the status report' do
      Kernel.should_receive( :puts ).with( kind_of( String ) )
      @rake[ 'status-cat:check' ].invoke
    end

  end

  describe 'rake status-cat:cron' do

    it 'calls StatusCat::Status.cron' do
      StatusCat::Status.should_receive( :cron )
      @rake[ 'status-cat:cron' ].invoke
    end

  end


end