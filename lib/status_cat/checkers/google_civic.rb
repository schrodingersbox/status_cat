module StatusCat
  module Checkers
    class GoogleCivic < Base

      cattr_accessor :api_key

      def initialize
        @value = api_key
        @status = fail_on_exception do
          response = ::HTTParty.get(url)
          response.code == 200 ? nil : 'fail'
        end
      end

      def url
        return "https://www.googleapis.com/civicinfo/v2/representatives?key=#{api_key}&address=94306"
      end
    end
  end
end
