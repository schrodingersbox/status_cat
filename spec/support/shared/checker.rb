shared_examples_for 'a status checker' do

  it 'inherits from StatusCat::Checker' do
    checker.should be_a_kind_of( StatusCat::Checkers::Base )
  end

  describe 'attributes' do

    it 'has a name reader' do
      expected = checker.class.to_s.split( '::' ).last.underscore.to_sym
      checker.name.should eql( expected )
    end

    it 'has a value reader' do
      checker.value.should eql( checker.value )
    end

    it 'has a status reader' do
      checker.status.should eql( checker.status )
    end

  end

end

