module StatusCat
  module Checkers
    class Dummy < Base
      def initialize
        @value = 'dummy'
        @status = %w[fail fail fail]
      end
    end
  end
end
