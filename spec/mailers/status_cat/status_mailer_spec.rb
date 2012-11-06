require 'spec_helper'

describe StatusCat::StatusMailer do

  it 'adds StatusCat::StatusHelper as a template helper' do
    modules = StatusCat::StatusMailer._helpers.included_modules
    modules.should include( StatusCat::StatusHelper )
  end

  describe '#failure' do

    let( :mail ) {  StatusCat::StatusMailer.failure( StatusCat::Status.all ) }
    let( :config ) { StatusCat.config }

    it 'uses the configured from address' do
      mail.from.should_not be_nil
      mail.from.should eql( [ config.from ] )
    end

    it 'uses the configured to address' do
      mail.to.should_not be_nil
      mail.to.should eql( [ config.to ] )
    end

    it 'uses the configured subject' do
      mail.subject.should_not be_nil
      mail.subject.should eql( config.subject )
    end

    it 'generates a multipart email with both text and html' do
      mail.parts.first.content_type.should eql( 'text/plain; charset=UTF-8' )
      mail.parts.second.content_type.should eql( 'text/html; charset=UTF-8' )
    end

  end

end

