module StatusCat
  module Checkers
    class S3 < Base

      def initialize
        if !defined?( ::AWS )
          @status = 'aws-sdk gem not installed'
        else
          @value = AWS.config.access_key_id
          @status = fail_on_exception do
            s3 = AWS::S3.new
            ( s3.buckets.count > 0 ) ? nil : 'no buckets'
          end
        end
      end

    end
  end
end