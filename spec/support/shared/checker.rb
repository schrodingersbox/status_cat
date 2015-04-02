shared_examples_for 'a status checker' do

  it 'inherits from StatusCat::Checker' do
    expect( checker ).to be_a_kind_of( StatusCat::Checkers::Base )
  end

  describe 'attributes' do

    it 'has a name reader' do
      expected = checker.class.to_s.split( '::' ).last.underscore.to_sym
      expect( checker.name ).to eql( expected )
    end

    it 'has a value reader' do
      expect( checker.value ).to eql( checker.value )
    end

    it 'has a status reader' do
      expect( checker.status ).to eql( checker.status )
    end
  end
end

