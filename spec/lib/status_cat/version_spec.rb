describe 'version' do

  it 'has a version constant' do
    expect(StatusCat::VERSION).to_not be_nil
    expect(StatusCat::VERSION).to be_an_instance_of(String)
    expect(StatusCat::VERSION).to match(/\d+\.\d+\.\d+/)
  end
end
