require 'singleton'

class StatusCat::Config
  include Singleton

  attr_accessor :from, :to, :subject, :noreply

end