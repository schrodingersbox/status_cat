module StatusCat

  class Checker

    def self.check( names = nil )
      # TODO implement
    end

    def fail_on_exception
      begin
        yield
      rescue Exception => e
        return e
      end
    end

  end

end