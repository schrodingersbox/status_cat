module StatusCat
  module Checkers

    class ActionMailerChecker < StatusCat::Checker

      def value
        settings       = ActionMailer::Base.smtp_settings
        return "#{settings[ :address ]}:#{settings[ :port ]}"
      end

      def status
        unless  ActionMailer::Base.delivery_method == :test
          fail_on_exception do
            Net::SMTP.start( address, port, domain, user_name, password, authentication ) { |smtp| }
          end
        end
      end

    end

  end
end