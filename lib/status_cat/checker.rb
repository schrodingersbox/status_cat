module StatusCat

  class Checker

    attr_reader :name

    def initialize( name, &declarations  )
      @name = name
    end

    def description( &block )
      @description_block = block
    end

  end

end