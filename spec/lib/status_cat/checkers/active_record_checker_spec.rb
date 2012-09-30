require 'spec_helper'

describe StatusCat::Checkers::ActiveRecordChecker do

  describe 'value' do

    it 'returns the ActiveRecord adapter, username and database'

  end

  describe 'status' do

    it 'passes if it can execute a query against the database'

    it 'returns an error message if it fails to query the database'

  end

end