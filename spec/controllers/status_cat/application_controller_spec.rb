require 'spec_helper'

describe StatusCat::ApplicationController do

  it 'inherits from the external application controller' do
    @controller.should be_a_kind_of( ::ApplicationController )
  end

end