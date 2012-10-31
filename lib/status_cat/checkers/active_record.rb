module StatusCat
  module Checkers
    class ActiveRecord < Base

      def initialize
        @value = "#{config[ :adapter ]}:#{config[ :username ]}@#{config[ :database ]}"

        @status = fail_on_exception do
          ::ActiveRecord::Base.connection.execute( "select max(version) from schema_migrations" )
        end
      end

      def config
        unless @config
          yaml =  YAML::load( ERB.new( IO.read( File.join( Rails.root, 'config', 'database.yml' ) ) ).result )
          @config = yaml[ Rails.env ].symbolize_keys!
        end
        return @config
      end

    end
  end
end