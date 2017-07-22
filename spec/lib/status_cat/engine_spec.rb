describe StatusCat::Engine do

  it 'isolates the StatusCat namespace' do
    expect(StatusCat::Engine.isolated).to be(true)
  end
end
