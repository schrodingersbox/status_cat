module StatusCat
  module Checkers
    class DummyChecker < Base
      def initialize
        @value = "dummy"
      end
    end
  end
end