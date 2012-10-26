require 'spec_helper'

describe StatusCat::StatusHelper do

  before( :each ) do
    @checker = StatusCat::Checkers::ActiveRecord.new
  end

  describe '#status_header' do

    it 'generates a status table header' do
      name = t( :name, :scope => :status_cat )
      value = t( :value, :scope => :status_cat )
      status = t( :status, :scope => :status_cat )
      expected = "<tr><th>#{name}</th><th>#{value}</th><th>#{status}</th></tr>"
      helper.status_header.should eql( expected )
    end

  end

  describe '#status_row' do

    it 'generates a status table row' do
      expected = "<tr><td style=\"#{helper.status_style( @checker )}\">#{@checker.name}</td><td>#{@checker.value}</td><td></td></tr>"
      helper.status_row( @checker ).should eql( expected )
    end

    it 'uses status_style to style the status column' do
      style = :gangnam
      helper.should_receive( :status_style ).and_return( style )
      expected = "<tr><td style=\"#{style}\">#{@checker.name}</td><td>#{@checker.value}</td><td></td></tr>"
      helper.status_row( @checker ).should eql( expected )
    end

  end

  describe '#status_style' do

    it 'returns a green background when the status is nil' do
      @checker.should_receive( :status ).and_return( nil )
      helper.status_style( @checker ).should eql( 'background-color: green' )
    end

    it 'returns a red background when the status is not nil' do
      @checker.should_receive( :status ).and_return( :fail )
      helper.status_style( @checker ).should eql( 'background-color: red' )
    end

  end

  describe '#status_table' do

    it 'generates a status table' do
      expected = "<table border=\"1\">#{helper.status_header}#{helper.status_row( @checker )}</table>"
      helper.status_table( [ @checker ] ).should eql( expected )
    end

  end

  describe '#status_title' do

    it 'generates a page title' do
      expected = "<h1>#{t( :h1, :scope => :status_cat )}</h1>"
      helper.status_title.should eql( expected )
    end

  end

end