shared_examples_for 'a StatusCat::Checker' do

  it 'inherits from StatusCat::Checker' do
    checker.should be_a_kind_of( StatusCat::Checker )
  end

  it 'has a name' do
    expected = checker.class.to_s.split( '::' ).last.gsub( /Checker$/, '' ).underscore.to_sym
    checker.name.should eql( expected )
  end

end

