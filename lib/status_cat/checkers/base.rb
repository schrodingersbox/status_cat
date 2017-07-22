module StatusCat
  module Checkers
    class Base
      extend ActiveSupport::DescendantsTracker

      FORMAT = "%s | %s | %s\n".freeze

      attr_reader :value, :status

      def self.class_to_name(klass)
        klass.to_s.split('::').last.underscore.to_sym
      end

      def name
        Base.class_to_name(self.class)
        # self.class.to_s.split('::').last.underscore.to_sym
      end

      def to_s(format = FORMAT)
        format(format, name, value, status || I18n.t(:ok, scope: :status_cat))
      end

      protected

      # rubocop:disable Lint/RescueException
      def fail_on_exception
        begin
          return yield
        rescue Exception => e
          return e
        end
        return nil
      end

      def gem_missing?(gem, present)
        return false if present

        @status = "#{gem} gem is not installed"
        return true
      end
    end
  end
end
