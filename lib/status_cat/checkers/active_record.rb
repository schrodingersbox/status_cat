module StatusCat
  module Checkers
    class ActiveRecord < Base

      def initialize
        @value = "#{adapter}:#{username}@#{database}"
        @status = fail_on_exception { test }
      end

      def test
        ::ActiveRecord::Base.connection.execute('select max(version) from schema_migrations')
        return nil
      end

      def config
        return ::ActiveRecord::Base.connection_config
      end

      def adapter
        return config[:adapter]
      end

      def database
        return config[:database]
      end

      def username
        return config[:username]
      end
    end
  end
end
