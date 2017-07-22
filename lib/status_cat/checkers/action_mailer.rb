module StatusCat
  module Checkers
    class ActionMailer < Base

      def initialize
        @value = "#{address}:#{port}"
        return if ::ActionMailer::Base.delivery_method == :test
        @status = fail_on_exception { test }
      end

      def test
        Net::SMTP.start(address, port, domain, user_name, password, authentication) do |smtp|
          smtp.helo(domain)
        end
        return nil
      end

      def config
        @config ||= ::ActionMailer::Base.smtp_settings
      end

      def address
        return config[:address]
      end

      def authentication
        return config[:authentication]
      end

      def domain
        return config[:domain]
      end

      def password
        return config[:password]
      end

      def port
        return config[:port]
      end

      def user_name
        return config[:user_name]
      end
    end
  end
end
