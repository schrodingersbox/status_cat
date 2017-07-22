module StatusCat
  module Checkers

    class Stripe < Base

      def initialize
        return if gem_missing?('stripe', defined?(::Stripe))

        @status = fail_on_exception do
          @value = account.email
          test
        end
      end

      def test
        return account.charge_enabled ? nil : 'Charge is not enabled'
      end

      def account
        return ::Stripe::Account.retrieve
      end
    end
  end
end
