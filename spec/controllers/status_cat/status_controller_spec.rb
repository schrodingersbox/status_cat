require 'spec_helper'

describe StatusCat::StatusController do

  routes { StatusCat::Engine.routes }

  describe '#index' do

    it 'gets successfully' do
      get :index
      response.should be_success
    end

    it 'assigns @checkers to StatusCat::Status.all' do
      get :index

      @checkers = assigns[ :checkers ]
      @checkers.should_not be( nil )
      @checkers.length.should eql( StatusCat::Status.all.length )
      @checkers.each { |checker| checker.should be_a_kind_of( StatusCat::Checkers::Base ) }
    end

    it 'uses the configured before authentication filter' do
      expect( @controller ).to receive( :instance_eval ).with( &StatusCat.config.authenticate_with )
      expect( @controller ).to receive( :instance_eval ).with( &StatusCat.config.authorize_with )
      get :index
    end

    it 'renders with the configured layout' do
      get :index
      expect( response ).to render_template( StatusCat.config.layout )
    end

  end

end
