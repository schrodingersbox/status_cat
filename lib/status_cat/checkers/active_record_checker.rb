module StatusCat
  module Checkers
    class ActiveRecordChecker < Base

      def initialize
        @value = "#{config[ 'adapter' ]}:#{config[ 'username' ]}@#{config[ 'database' ]}"

        @status = fail_on_exception do
          ActiveRecord::Base.connection.execute( "select max(version) from schema_migrations" )
        end
      end

      def config
        YAML::load( ERB.new( IO.read( "#{Rails.root}/config/database.yml" ) ).result )[ Rails.env ]
      end

    end
  end
end