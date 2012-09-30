module StatusCat

  module Checkers

    class ActiveRecordChecker < StatusCat::Checker

      def value
        config       = YAML::load( ERB.new( IO.read( "#{Rails.root}/config/database.yml" ) ).result )
        adapter      = config[ connector ][ 'adapter' ]
        username     = config[ connector ][ 'username' ]
        database     = config[ connector ][ 'database' ]

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