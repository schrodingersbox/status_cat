require 'spec_helper'

describe StatusCat::StatusController do

  it 'gets the index action' do
    get :index, :use_route => :status_cat
    response.should be_success
  end

end
