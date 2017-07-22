module StatusCat
  module Checkers
    class Fitbit < Base

      def initialize
        return if gem_missing?('fitgem', defined?(::Fitgem))

        @value = ENV['FITBIT_CONSUMER_KEY']
        @status = fail_on_exception do
          user_info = ::Fitgem::Client.new(
            consumer_key: ENV['FITBIT_CONSUMER_KEY'],
            consumer_secret: ENV['FITBIT_CONSUMER_SECRET'],
            token: ENV['FITBIT_TEST_TOKEN'],
            secret: ENV['FITBIT_TEST_SECRET'],
            user_id: ENV['FITBIT_TEST_USER_ID']
          ).user_info

          user_info['errors'] ? user_info.inspect : nil
        end
      end
    end
  end
end
