require 'spec_helper'

describe StatusCat::StatusHelper do

  let( :checker ) { StatusCat::Checkers::ActiveRecord.new }
  let( :name ) { t( :name, :scope => :status_cat ).freeze }
  let( :value ) { t( :value, :scope => :status_cat ).freeze }
  let( :status ) { t( :status, :scope => :status_cat ).freeze }
  let( :ok ) { t( :ok, :scope => :status_cat ).freeze }

  describe '#status_header' do

    it 'generates a status table header' do
      expected = "<tr><th>#{name}</th><th>#{value}</th><th>#{status}</th></tr>"
      helper.status_header.should eql( expected )
    end

  end

  describe '#status_row' do

    it 'generates a status table row' do
      expected = "<tr><td style=\"#{helper.status_style( checker )}\">#{checker.name}</td><td>#{checker.value}</td><td>#{ok}</td></tr>"
      helper.status_row( checker ).should eql( expected )
    end

    it 'uses status_style to style the status column' do
      style = :gangnam
      helper.should_receive( :status_style ).and_return( style )
      expected = "<tr><td style=\"#{style}\">#{checker.name}</td><td>#{checker.value}</td><td>#{ok}</td></tr>"
      helper.status_row( checker ).should eql( expected )
    end

  end

  describe '#status_cell' do

    it 'returns the status as a table cell' do
      expected = "<td>foo</td>"
      expect( helper.status_cell( 'foo' ) ).to eql( expected )
    end

    it 'converts array statuses into html lists' do
      expected = "<td><ul><li>foo</li><li>bar</li></ul></td>"
      expect( helper.status_cell( [ 'foo', 'bar' ] ) ).to eql( expected )
    end

  end

  describe '#status_style' do

    it 'returns a green background when the status is nil' do
      checker.should_receive( :status ).and_return( nil )
      helper.status_style( checker ).should eql( 'background-color: green' )
    end

    it 'returns a red background when the status is not nil' do
      checker.should_receive( :status ).and_return( :fail )
      helper.status_style( checker ).should eql( 'background-color: red' )
    end

  end

  describe '#status_table' do

    it 'generates a status table' do
      expected = "<table border=\"1\">#{helper.status_header}#{helper.status_row( checker )}</table>"
      helper.status_table( [ checker ] ).should eql( expected )
    end

  end

  describe '#status_title' do

    it 'generates a page title' do
      expected = "<h1>#{t( :h1, :scope => :status_cat )}</h1>"
      helper.status_title.should eql( expected )
    end

  end

  describe '#status_report' do

    it 'generates a text status report' do
      all = StatusCat::Status.all
      all.each { |s| s.stub( :status ).and_return( nil ) }

      actual = helper.status_report( all )
      all.each { |s| actual.should =~ /#{s}/ }
    end

  end

  describe '#status_report_format' do

    it 'generates a format string and length based on the max length of the given checkers' do
      all = StatusCat::Status.all
      all.each { |s| s.stub( :status ).and_return( nil ) }

      status_report_format = helper.status_report_format( all ).to_s
      status_report_format.should =~ /\["%\d+s | %\d+s | %\d+s\n", \d+\]/
    end

  end

  describe '#status_report_header' do

    it 'generates a header' do
      expected = sprintf( StatusCat::Checkers::Base::FORMAT, name, value, status )
      helper.status_report_header.should eql( expected )
    end

    it 'accepts a format string' do
      format = '%s * %s * %s'
      expected = sprintf( format, name, value, status )
      helper.status_report_header( format ).should eql( expected )
    end

  end

end