require 'singleton'

module StatusCat

  class Config
    include Singleton

    attr_accessor :enabled, :from, :to, :subject, :noreply

    def initialize
      @enabled = StatusCat::Checkers::Base.descendants.map { |klass|
        klass.to_s.split( '::' ).last.underscore.to_sym
      }.sort
    end

  end

end