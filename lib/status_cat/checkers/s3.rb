module StatusCat
  module Checkers
    class S3 < Base

      def initialize
        if !defined?( ::Aws )
          @status = 'aws-sdk gem not installed'
        else
          @value = Aws.config[:credentials].access_key_id
          @status = fail_on_exception do
            s3 = Aws::S3::Resource.new
            ( s3.buckets.count > 0 ) ? nil : 'no buckets'
          end
        end
      end

    end
  end
end