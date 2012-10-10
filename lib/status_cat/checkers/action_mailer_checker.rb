module StatusCat
  module Checkers

    class ActionMailerChecker < StatusCat::Checker

      def name
        return :action_mailer
      end

      def value
        settings       = ActionMailer::Base.smtp_settings
        return "#{settings[ :address ]}:#{settings[ :port ]}"
      end

      def status
        unless  ActionMailer::Base.delivery_method == :test
          fail_on_exception do
            settings       = ActionMailer::Base.smtp_settings
            address        = settings[ :address ]
            port           = settings[ :port ]
            domain         = settings[ :domain ]
            user_name      = settings[ :user_name ]
            password       = settings[ :password ]
            authentication = settings[ :authentication ]

            Net::SMTP.start( address, port, domain, user_name, password, authentication ) { |smtp| }
          end
        end
      end

    end

  end
end