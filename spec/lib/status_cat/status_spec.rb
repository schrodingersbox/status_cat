require 'spec_helper'

describe StatusCat::Status do

  #############################################################################
  # ::all
  #############################################################################

  describe '::all' do

    before( :all ) do
      @all = StatusCat::Status.all.freeze
    end

    it 'returns an array of all checkers' do
      @all.should be_an_instance_of( Array )
      @all.length.should eql( StatusCat::Checkers::Base.descendants.length )
      @all.each { |checker| checker.should be_a_kind_of( StatusCat::Checkers::Base ) }
    end

    it 'returns the array in alphabetical order' do
      expected = @all.sort { |a,b| a.name.to_s <=> b.name.to_s }
      @all.should eql( expected )
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
  # ::factory
  #############################################################################

  describe '::factory' do

    it 'constructs a checker given its symbolic name' do
      StatusCat::Status.factory( :action_mailer ).should be_an_instance_of( StatusCat::Checkers::ActionMailer )
      StatusCat::Status.factory( :active_record ).should be_an_instance_of( StatusCat::Checkers::ActiveRecord )
    end

  end

  #############################################################################
  # ::report
  #############################################################################

  describe '::report' do

    it 'generates a text status report' do
      StatusCat::Status.report.should eql_file( 'spec/data/report.txt' )
    end

  end

  describe '::report_format' do

    it 'generates a format string and length based on the max length of the given checkers' do
      expected = [ "%13s | %24s | %0s\n", 43 ]
      StatusCat::Status.report_format( StatusCat::Status.all ).should eql( expected )
    end

  end

  describe '::report_header' do

    before( :all ) do
      @name = I18n.t( :name, :scope => :status_cat ).freeze
      @value = I18n.t( :value, :scope => :status_cat ).freeze
      @status = I18n.t( :status, :scope => :status_cat ).freeze
    end

    it 'generates a header' do
      expected = sprintf( StatusCat::Checkers::Base::FORMAT, @name, @value, @status )
      StatusCat::Status.report_header.should eql( expected )
    end

    it 'accepts a format string' do
      format = '%s * %s * %s'
      expected = sprintf( format, @name, @value, @status )
      StatusCat::Status.report_header( format ).should eql( expected )
    end

  end

end

