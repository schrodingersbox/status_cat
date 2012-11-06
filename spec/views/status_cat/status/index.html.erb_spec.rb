require 'spec_helper'

describe 'status_cat/status/index.html.erb' do

  before( :each ) do
    @checkers = StatusCat::Status.all
    assign( :checkers, @checkers )
  end

  it 'includes an h1 tag' do
    render
    rendered.should have_selector( :h1, :content => t( :h1, :scope => :status_cat )  )
  end

  it 'uses the status_title helper'  do
    view.should_receive( :status_title )
    render
  end

  it 'uses the status_table helper'  do
    view.should_receive( :status_table ).with( @checkers )
    render
  end

end