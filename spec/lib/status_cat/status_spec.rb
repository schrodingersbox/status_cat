require 'spec_helper'

describe StatusCat::Status do

  #############################################################################
  # ::all
  #############################################################################

  describe '::all' do

    it 'returns an array of enabled checkers' do
      enabled = StatusCat::Config.instance.enabled
      StatusCat::Config.instance.should_receive( :enabled ).and_return( enabled )

      all = StatusCat::Status.all
      all.should be_an_instance_of( Array )
      all.length.should eql( StatusCat::Checkers::Base.descendants.length )
      all.each { |checker| checker.should be_a_kind_of( StatusCat::Checkers::Base ) }
    end

  end

  #############################################################################
  # ::check
  #############################################################################

  describe '::check' do

    def checker_array_should_have_names( actual, expected )
      actual.should be_a_kind_of( Array )
      actual.length.should eql( expected.length )
      actual.each_index { |i| actual[ i ].name.should be( expected[ i ] ) }
    end

    it 'defaults to all checkers' do
      names = StatusCat::Status.all.map { |checker| checker.name }
      checkers = StatusCat::Status.check
      checker_array_should_have_names( checkers, names )
    end

    it 'returns all checkers when :all is specified' do
      names = StatusCat::Status.all.map { |checker| checker.name }
      checkers = StatusCat::Status.check( :all )
      checker_array_should_have_names( checkers, names )
    end

    it 'returns a single checker when given a single symbolic name' do
      StatusCat::Status.check( :active_record ).should be_an_instance_of( StatusCat::Checkers::ActiveRecord )
    end

    it 'returns an array of checkers when given an array of symbolic name' do
      names = [ :active_record, :action_mailer ]
      checkers = StatusCat::Status.check( names )
      checker_array_should_have_names( checkers, names )
    end

  end

  #############################################################################
  # ::cron
  #############################################################################

  describe '::cron' do

    it 'delivers email if ::failed is not empty' do
      failed = [ StatusCat::Checkers::Base.new ]
      mail =  StatusCat::StatusMailer.failure( failed )
      StatusCat::Status.should_receive( :failed ).and_return( failed )
      StatusCat::StatusMailer.should_receive( :failure ).with( failed ).and_return( mail )
      StatusCat::Status.cron
    end

    it 'does not email when ::failed is empty' do
      StatusCat::Status.should_receive( :failed ).and_return( [] )
      StatusCat::StatusMailer.should_not_receive( :failure )
      StatusCat::Status.cron
    end

  end

  #############################################################################
  # ::factory
  #############################################################################

  describe '::factory' do

    it 'constructs a checker given its symbolic name' do
      StatusCat::Status.factory( :action_mailer ).should be_an_instance_of( StatusCat::Checkers::ActionMailer )
      StatusCat::Status.factory( :active_record ).should be_an_instance_of( StatusCat::Checkers::ActiveRecord )
    end

  end

  #############################################################################
  # ::failed
  #############################################################################

  describe '::failed' do

    before( :each ) do
      @pass = StatusCat::Checkers::Base.new

      @fail = StatusCat::Checkers::Base.new
      @fail.stub!( :status ).and_return( :fail )
    end

    it 'returns only failed checkers from ::all' do
      StatusCat::Status.should_receive( :all ).and_return( [ @pass, @fail ] )
      StatusCat::Status.failed.should eql( [ @fail ] )
    end

    it 'returns an empty list if all checkers pass' do
      StatusCat::Status.should_receive( :all ).and_return( [ @pass ] )
      StatusCat::Status.failed.should eql( [] )
    end

  end

end

