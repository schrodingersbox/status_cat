require 'singleton'

module StatusCat

  class Config
    include Singleton

    NIL_PROC = proc {}

    attr_accessor :enabled
    attr_accessor :authenticate, :authorize
    attr_accessor :from, :to, :subject, :noreply
    attr_accessor :layout

    def initialize
      @enabled = StatusCat::Checkers::Base.descendants.map { |klass|
        StatusCat::Checkers::Base.class_to_name( klass )
      }.sort
    end

    def authenticate_with(&blk)
      @authenticate = blk if blk
      @authenticate || NIL_PROC
    end

    def authorize_with(&block)
      @authorize = block if block
      @authorize || NIL_PROC
    end

  end

end