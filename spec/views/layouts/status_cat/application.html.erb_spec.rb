require 'spec_helper'

describe '/layouts/status_cat/application.html.erb' do

  it 'renders without exception' do
    render
  end

  it 'includes a title tag' do
    render
    rendered.should have_selector( :title, :content => 'StatusCat' )
  end

end
