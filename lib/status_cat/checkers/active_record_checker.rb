module StatusCat

  module Checkers

    class ActiveRecordChecker < StatusCat::Checker

      def value
        config       = YAML::load( ERB.new( IO.read( "#{Rails.root}/config/database.yml" ) ).result )
        adapter      = config[ Rails.env ][ 'adapter' ]
        username     = config[ Rails.env ][ 'username' ]
        database     = config[ Rails.env ][ 'database' ]

        return "#{adapter}:#{username}@#{database}"
      end

      def status
        fail_on_exception do
          ActiveRecord::Base.connection.execute( "select max(version) from schema_migrations" )
        end
      end

    end

  end

end