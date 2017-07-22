module StatusCat
  module Checkers
    class Profilesio < Base

      cattr_accessor :api_key

      def initialize
        @value = api_key
        @status = fail_on_exception do
          response = ::HTTParty.get('https://profiles.io/record/register')
          response.code == 200 ? nil : 'fail'
        end
      end
    end
  end
end
