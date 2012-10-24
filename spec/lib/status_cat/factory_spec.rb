require 'spec_helper'

describe StatusCat::Factory do

  it 'builds checkers' do
    StatusCat::Factory.check( :action_mailer ).should be_an_instance_of( StatusCat::Checkers::ActionMailerChecker )
    StatusCat::Factory.check( :active_record ).should be_an_instance_of( StatusCat::Checkers::ActiveRecordChecker )
  end

  it 'returns a list of all Checkers' do
    all = StatusCat::Factory.all
    all.should be_an_instance_of( Array )
    all.length.should > 0
    all.each { |checker| checker.should be_a_kind_of( StatusCat::Checker ) }
  end


end

