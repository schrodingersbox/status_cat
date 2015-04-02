describe StatusCat::Config do

  let( :config ) { StatusCat::Config.instance }

  it 'is a singleton' do
    expect( config ).to be( StatusCat::Config.instance )
  end

  describe 'attributes' do

    it 'has an #authenticate accessor' do
       config.authenticate = config.authenticate
      expect( config.authenticate ).to eql( config.authenticate )
    end

    it 'has an #authorize accessor' do
      config.authorize = config.authorize
      expect( config.authorize ).to eql( config.authorize )
    end

    it 'has an #enabled accessor' do
      expect( config.enabled ).to_not be_nil
      config.enabled = config.enabled
      expect( config.enabled ).to eql( config.enabled )
    end

    it 'has a #from accessor' do
      expect( config.from ).to_not be_nil
      config.from = config.from
      expect( config.from ).to eql( config.from )
    end

    it 'has a #layout accessor' do
      expect( config.layout ).to_not be_nil
      config.layout = config.layout
      expect( config.layout ).to eql( config.layout )
    end

    it 'has a #noreply accessor' do
      expect( config.noreply ).to_not be_nil
      config.noreply = config.noreply
      expect( config.noreply ).to eql( config.noreply )
    end

    it 'has a #to accessor' do
      expect( config.to ).to_not be_nil
      config.to = config.to
      expect( config.to ).to eql( config.to )
    end

    it 'has an #subject accessor' do
      expect( config.subject ).to_not be_nil
      config.subject = config.subject
      expect( config.subject ).to eql( config.subject )
    end
  end

  describe '#initialize' do

    it 'defaults the #enabled list to all StatusCat::Checkers::Base subclasses' do
      descendants = StatusCat::Checkers::Base.descendants
      expect( StatusCat::Checkers::Base ).to receive( :descendants ).and_return( descendants )

      config.enabled = nil
      config.send( :initialize )
      expect( config.enabled ).to_not be_nil
    end
  end

  describe '#authenticate_with' do

    before( :each ) do
      @authenticate = config.authenticate
    end

    after( :each ) do
      config.authenticate = @authenticate
    end

    it 'accepts a block' do
      config.authenticate = nil
      config.authenticate_with do
        true
      end

      expect( config.authenticate ).to_not be_nil
    end

    it 'returns a block' do
      @test = false
      config.authenticate_with do
        @test = true
      end

      instance_eval( &config.authenticate_with )
      expect( @test ).to be( true )
    end

    it 'returns a nil proc if none has been set' do
      config.authenticate = nil
      instance_eval( &config.authenticate_with )
    end
  end

  describe '#authorize_with' do

    before( :each ) do
      @authorize = config.authorize
    end

    after( :each ) do
      config.authorize = @authorize
    end

    it 'accepts a block' do
      config.authorize = nil
      config.authorize_with do
        true
      end

      expect( config.authorize ).to_not be_nil
    end

    it 'returns a block' do
      @test = false
      config.authorize_with do
        @test = true
      end

      instance_eval( &config.authorize_with )
      expect( @test ).to be( true )
    end

    it 'returns a nil proc if none has been set' do
      config.authorize = nil
      instance_eval( &config.authorize_with )
    end
  end
end

