module StatusCat
  module Checkers
    class SendHub < Base

      cattr_accessor :api_key
      cattr_accessor :number

      def initialize
        return if gem_missing?('ruby-sendhub', defined?(::SendHub))

        @value = number
        @status = fail_on_exception do
          send_hub = ::SendHub.new(api_key, number)
          send_hub.get_contacts ? nil : 'fail'
        end
      end
    end
  end
end
