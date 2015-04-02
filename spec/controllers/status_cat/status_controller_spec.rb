describe StatusCat::StatusController do

  routes { StatusCat::Engine.routes }

  describe '#index' do

    it 'gets successfully' do
      get :index
      expect( response ).to be_success
    end

    it 'assigns @checkers to StatusCat::Status.all' do
      get :index

      @checkers = assigns[ :checkers ]
      expect( @checkers ).to_not be( nil )
      expect( @checkers.length ).to eql( StatusCat::Status.all.length )
      @checkers.each { |checker| expect( checker ).to be_a_kind_of( StatusCat::Checkers::Base ) }
    end

    it 'uses the configured before authentication filter' do
      allow( Rails.env ).to receive( :test? ).and_return( false )
      expect( controller  ).to receive( :authenticate! )
      expect( controller ).to receive( :authorize! )

      get :index
    end

    it 'renders with the configured layout' do
      get :index
      expect( response ).to render_template( StatusCat.config.layout )
    end
  end
end
