require 'spec_helper'

describe StatusCat::StatusController do

  it 'gets the index action' do
    get :index
    response.should be_success
  end

end