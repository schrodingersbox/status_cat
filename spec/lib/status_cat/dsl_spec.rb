require 'spec_helper'

describe StatusCat::DSL do

  it 'allows you to define a checker' do
    test_dsl
  end

  it 'allows you to check a checker' do
    test_dsl
  end

  def test_dsl

    StatusCat.define :test_dsl do

      description do
        'This is only a test'
      end

    end

    StatusCat.check( :test_dsl ).name.should be( :test_dsl )

  end

end