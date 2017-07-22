module StatusCat
  module Checkers
    class Fitbit < Base

      cattr_accessor :consumer_key
      cattr_accessor :consumer_secret
      cattr_accessor :test_token
      cattr_accessor :test_secret
      cattr_accessor :test_user_id

      def initialize
        return if gem_missing?('fitgem', defined?(::Fitgem))

        @value = consumer_key
        @status = fail_on_exception do
          user_info = ::Fitgem::Client.new(
            consumer_key: consumer_key,
            consumer_secret: consumer_secret,
            token: test_token,
            secret: test_secret,
            user_id: test_user_id
          ).user_info

          user_info['errors'] ? user_info.inspect : nil
        end
      end
    end
  end
end
