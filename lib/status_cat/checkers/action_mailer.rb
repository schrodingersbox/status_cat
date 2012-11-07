module StatusCat
  module Checkers
    class ActionMailer < Base

      def initialize
        @value = "#{config[ :address ]}:#{config[ :port ]}"

        unless  ::ActionMailer::Base.delivery_method == :test
          @status = fail_on_exception do
            address        = config[ :address ]
            port           = config[ :port ]
            domain         = config[ :domain ]
            user_name      = config[ :user_name ]
            password       = config[ :password ]
            authentication = config[ :authentication ]

            Net::SMTP.start( address, port, domain, user_name, password, authentication ) do |smtp|
              smtp.send_message( '', StatusCat.config.from, StatusCat.config.noreply )
            end
          end
        end
      end

      def config
        @config ||= ::ActionMailer::Base.smtp_settings
      end

    end
  end
end