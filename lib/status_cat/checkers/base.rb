# Base class for all status checkers

module StatusCat
  module Checkers
    class Base
      attr_reader :value, :status

      def self.factory( name )
        ( 'StatusCat::Checkers::' + name.to_s.classify + 'Checker' ).constantize.new
      end

      def name
        return self.class.to_s.split( '::' ).last.gsub( /Checker$/, '' ).underscore.to_sym
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
