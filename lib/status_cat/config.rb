require 'singleton'

class StatusCat::Config
  include Singleton

  attr_accessor :enabled, :from, :to, :subject, :noreply

  def initialize
    @enabled = StatusCat::Checkers::Base.descendants.map { |klass| klass.new.name }.sort
  end

end