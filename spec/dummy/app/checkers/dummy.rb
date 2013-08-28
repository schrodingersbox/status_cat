module StatusCat
  module Checkers
    class Dummy < Base
      def initialize
        @value = 'dummy'
        @status = 'fail'
      end
    end
  end
end