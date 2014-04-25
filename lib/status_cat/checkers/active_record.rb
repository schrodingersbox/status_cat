module StatusCat
  module Checkers
    class ActiveRecord < Base

      def initialize
        config = ::ActiveRecord::Base.connection_config
        @value = "#{config[ :adapter ]}:#{config[ :username ]}@#{config[ :database ]}"

        @status = fail_on_exception do
          ::ActiveRecord::Base.connection.execute( "select max(version) from schema_migrations" )
          nil
        end
      end

    end
  end
end