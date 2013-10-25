module StatusCat
  module Checkers

    class Stripe < Base
      def initialize
        if !defined?( ::Stripe )
          @status = 'stripe gem not installed'
        else
          @status = fail_on_exception do
            account = ::Stripe::Account.retrieve()
            @value = account.email
            account.charge_enabled ? nil : 'Charge is not enabled'
          end
        end
      end
    end

  end
end