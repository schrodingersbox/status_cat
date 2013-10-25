module StatusCat
  module Checkers

    class DelayedJob < Base
      include ActionView::Helpers::DateHelper

      def initialize
        if !defined?( ::Delayed )
          @status = 'delayed_job gem not installed'
        else
          @status = fail_on_exception do
            sql = 'select count(*) from delayed_jobs'
            result = ::ActiveRecord::Base.connection.execute( sql ).first
            @value = result.is_a?( Hash ) ? result[ 'count' ] : result[ 0 ]

            expires = 1.day.ago
            sql = "select count(*) from delayed_jobs where created_at < '#{expires.to_s( :db )}'"
            result = ::ActiveRecord::Base.connection.execute( sql ).first
            value = result.is_a?( Hash ) ? result[ 'count' ] : result[ 0 ]

            ( value.to_i == 0 ) ? nil : "#{value} jobs more than #{time_ago_in_words( expires )} old"
          end
        end
      end
    end

  end
end