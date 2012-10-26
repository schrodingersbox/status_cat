require 'spec_helper'

describe StatusCat::Status do

  describe '::all' do

    before( :each ) do
      @all = StatusCat::Status.all
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

  it '::factory constructs a checker given its symbolic name' do
    StatusCat::Status.factory( :action_mailer ).should be_an_instance_of( StatusCat::Checkers::ActionMailer )
    StatusCat::Status.factory( :active_record ).should be_an_instance_of( StatusCat::Checkers::ActiveRecord )
  end

end

