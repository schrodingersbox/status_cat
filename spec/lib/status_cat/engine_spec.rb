require 'spec_helper'

describe StatusCat::Engine do

  it 'isolates the StatusCat namespace' do
    StatusCat::Engine.isolated.should be( true )
  end

end