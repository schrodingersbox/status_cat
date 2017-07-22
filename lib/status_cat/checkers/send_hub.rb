module StatusCat
  module Checkers
    class SendHub < Base
      def initialize
        @value = ENV['SEND_HUB_NUMBER']
        @status = fail_on_exception do
          send_hub = ::SendHub.new(ENV['SEND_HUB_API_KEY'], ENV['SEND_HUB_NUMBER'])
          send_hub.get_contacts ? nil : 'fail'
        end
      end
    end
  end
end
