require 'spec_helper'

describe StatusCat::Checkers::Stripe do

  let( :checker ) { StatusCat::Checkers::Stripe.new.freeze }

  before( :each ) do

  end

  it_should_behave_like 'a status checker'

end