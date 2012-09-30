require 'spec_helper'

describe StatusCat::Checkers::ActionMailerChecker do

  describe 'value' do

    it 'returns the ActionMailer SMTP address and port'

  end

  describe 'status' do

    it 'always passes for the test delivery method'

    it 'passes if it can make an SMTP connection'

    it 'returns an error message if it can not make an SMTP connection'

  end

end