module StatusCat
  module Checkers
    class DummyChecker < Base
      def initialize
        @value = 'dummy'
        @status = 'fail'
      end
    end
  end
end