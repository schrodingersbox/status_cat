module StatusCat
  module Checkers
    class Base
      extend ActiveSupport::DescendantsTracker

      FORMAT = "%s | %s | %s\n"

      attr_reader :value, :status

      def name
        self.class.to_s.split( '::' ).last.underscore.to_sym
      end

      def to_s( format = FORMAT )
        sprintf( format, name, value, status )
      end

    protected

      def fail_on_exception
        begin
          yield
        rescue Exception => e
          return e
        end

        return nil
      end
    end
  end
end
