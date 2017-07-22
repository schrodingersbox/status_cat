require 'stripe'

describe StatusCat::Checkers::Stripe do

  let(:checker) { StatusCat::Checkers::Stripe.new.freeze }
  let(:email) { 'foo@bar.com' }

  it_should_behave_like 'a status checker'

  it 'tolerates Stripe being undefined' do
    stripe = Object.send(:remove_const, :Stripe)
    expect(checker.status).to_not be_nil
    Object.const_set(:Stripe, stripe)
  end

  it 'fails if there is an exception talking to Stripe' do
    expect(@stripe).to receive(:email).and_raise('test error')
    expect(checker.status).to_not be_nil
  end

  it 'fails if charging is not enabled' do
    expect(@stripe).to receive(:charge_enabled).and_return(false)
    expect(@stripe).to receive(:email).and_return(email)
    expect(checker.status).to_not be_nil
  end

  it 'passes if charging is enabled' do
    expect(@stripe).to receive(:charge_enabled).and_return(true)
    expect(@stripe).to receive(:email).and_return(email)
    expect(checker.status).to be_nil
  end

  it 'uses the account email as the value' do
    expect(@stripe).to receive(:charge_enabled).and_return(true)
    expect(@stripe).to receive(:email).and_return(email)
    expect(checker.value).to eql(email)
  end
end
