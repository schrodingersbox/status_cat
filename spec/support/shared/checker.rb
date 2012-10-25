shared_examples_for 'a StatusCat::Checker' do

  it 'inherits from StatusCat::Checker' do
    checker.should be_a_kind_of( StatusCat::Checkers::Base )
  end

  it 'has a name attribute reader' do
    expected = checker.class.to_s.split( '::' ).last.gsub( /Checker$/, '' ).underscore.to_sym
    checker.name.should eql( expected )
  end

  it 'has a value attribute reader' do
    checker.value.should_not be_nil
  end

  it 'has a status attribute reader' do
    checker.status.should be_nil
  end

end

