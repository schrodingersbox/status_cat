module StatusCat
  module Checkers
    class ActionMailerChecker < Base

      def initialize
        @value = "#{config[ :address ]}:#{config[ :port ]}"

        unless  ActionMailer::Base.delivery_method == :test
          @status = fail_on_exception do
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

      def config
        ActionMailer::Base.smtp_settings
      end

    end
  end
end