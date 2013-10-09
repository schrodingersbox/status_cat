module StatusCat
  module Checkers
    class Stripe < Base
      def initialize
        @value = ''
        if defined?( ::Stripe )
          @status = fail_on_exception do
            if defined?( ::Stripe )
              account = ::Stripe::Account.retrieve()
              @value = account.email
              account.charge_enabled ? nil : 'Charge is not enabled'
            end
          end
        end
      end
    end
  end
end