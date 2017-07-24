module StatusCat
  module Checkers
    class Slack < Base

      def initialize
        return if gem_missing?('slack-ruby-client', defined?(::Slack))

        @value = ::Slack.config.token
        @status = fail_on_exception do
          message = ::Slack::Web::Client.new.auth_test
          message.ok? ? nil : message.to_s
        end
      end
    end
  end
end
