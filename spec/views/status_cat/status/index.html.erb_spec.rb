describe 'status_cat/status/index.html.erb' do

  before( :each ) do
    @checkers = StatusCat::Status.all
    assign( :checkers, @checkers )
  end

  it 'includes an h1 tag' do
    render
    expect( rendered ).to match( /<h1>#{t( :h1, :scope => :status_cat )}<\/h1>/ )
  end

  it 'uses the status_title helper'  do
    expect( view ).to receive( :status_title )
    render
  end

  it 'uses the status_table helper'  do
    expect( view ).to receive( :status_table ).with( @checkers )
    render
  end

end