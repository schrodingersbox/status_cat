require 'spec_helper'

describe 'status_cat/status/index.html.erb' do

  it 'includes an h1 tag' do
    render
    rendered.should have_selector( :h1, :content => t( :h1, :scope => :status_cat )  )
  end

end