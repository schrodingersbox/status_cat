module StatusCat
  module Checkers
    class Profilesio < Base
      def initialize
        @value = ENV['PROFILESIO_KEY']
        @status = fail_on_exception do
          response = ::HTTParty.get('https://profiles.io/record/register')
          response.code == 200 ? nil : 'fail'
        end
      end
    end
  end
end
