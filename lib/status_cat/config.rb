require 'singleton'

module StatusCat

  class Config
    include Singleton

    attr_accessor :enabled, :from, :to, :subject, :noreply

    def initialize
      @enabled = StatusCat::Checkers::Base.descendants.map { |klass|
        StatusCat::Checkers::Base.class_to_name( klass )
      }.sort
    end

  end

end