require 'status_cat/config'
require 'status_cat/engine'
require 'status_cat/status'

require 'status_cat/checkers/base'
require 'status_cat/checkers/action_mailer'
require 'status_cat/checkers/active_record'
require 'status_cat/checkers/s3'
require 'status_cat/checkers/stripe'

module StatusCat

  def self.config
    return StatusCat::Config.instance
  end

  def self.configure
    yield config
  end

end