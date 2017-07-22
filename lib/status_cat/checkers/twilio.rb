module StatusCat
  module Checkers
    class Twilio < Base
      def initialize
        return if gem_missing?('twilio-ruby', defined?(::Twilio))

        @value = ENV['TWILIO_SID']
        @status = fail_on_exception do
          twilio = ::Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
          twilio.api.account.messages.total ? nil : 'fail'
        end
      end
    end
  end
end
