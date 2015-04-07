module StatusCat
  module Checkers
    class Twilio < Base
      def initialize
        @value = ENV[ 'TWILIO_SID' ]
        @status = fail_on_exception do
          twilio = ::Twilio::REST::Client.new( ENV[ 'TWILIO_SID' ], ENV[ 'TWILIO_TOKEN' ] )
          twilio.account.messages.total ? nil : 'fail'
        end
      end
    end
  end
end