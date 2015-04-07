describe StatusCat::Checkers::Fitbit do

  let( :checker ) { StatusCat::Checkers::Fitbit.new.freeze }

  it_should_behave_like 'a status checker'

  describe '#initialize' do

    it 'sets the value' do
      expect( checker.value ).to eql( ENV[ 'FITBIT_CONSUMER_KEY' ] )
    end

    context 'pass' do

      it 'passes if it can connect to Fitbit' do
        expect( checker.status ).to be_nil
      end
    end

    context 'fail' do

      it 'fails if it receives errors' do
        expect( @fitgem ).to receive( :user_info ).and_return( { 'errors' => 'this is only a test' } )
        expect( checker.status ).to_not be_nil
      end

      it 'fails if there is an exception' do
        expect( @fitgem ).to receive( :user_info ).and_raise( 'This is only a test' )
        expect( checker.status ).to_not be_nil
      end
    end
  end
end