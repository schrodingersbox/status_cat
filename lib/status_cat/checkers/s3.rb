module StatusCat
  module Checkers
    class S3 < Base

      def initialize
        return if gem_missing?('aws-sdk', defined?(::Aws))

        @value = Aws.config[:credentials].access_key_id
        @status = fail_on_exception { test }
      end

      def test
        s3 = Aws::S3::Resource.new
        return s3.buckets.count.zero? ? 'no buckets' : nil
      end
    end
  end
end
