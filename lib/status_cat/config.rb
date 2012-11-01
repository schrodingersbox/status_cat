require 'singleton'

class StatusCat::Config
  include Singleton

  attr_accessor :email_from, :email_to, :email_subject
end