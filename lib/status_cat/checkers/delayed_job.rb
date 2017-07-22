module StatusCat
  module Checkers

    class DelayedJob < Base
      include ActionView::Helpers::DateHelper

      NOT_INSTALLED = 'delayed_job gem not installed'.freeze

      def initialize
        @status = defined?(::Delayed) ? fail_on_exception { test } : NOT_INSTALLED
      end

      def test
        @value = count_jobs

        expires = 1.day.ago
        expired = count_expired(expires)
        expired.zero? ? nil : "#{expired} jobs more than #{time_ago_in_words(expires)} old"
      end

      def count_jobs
        sql = 'select count(*) from delayed_jobs where failed_at is null'
        result = ::ActiveRecord::Base.connection.execute(sql).first
        return result.is_a?(Hash) ? result['count'] : result[0]
      end

      def count_expired(expires)
        sql = "select count(*) from delayed_jobs where created_at < '#{expires.to_s(:db)}' and failed_at is null"
        result = ::ActiveRecord::Base.connection.execute(sql).first
        return result.is_a?(Hash) ? result['count'] : result[0]
      end
    end
  end
end
