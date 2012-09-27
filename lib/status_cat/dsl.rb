module StatusCat

  module DSL

    @@checkers = {}

    def define( name, &block )
      @@checkers[ :name ] = StatusCat::Checker.new( name, &block )
    end

    def check( name )
      @@checkers[ :name ]
    end

  end

end

StatusCat.extend StatusCat::DSL