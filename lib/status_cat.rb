require 'require_all'

require 'status_cat/config'
require 'status_cat/engine'
require 'status_cat/status'

require 'status_cat/checkers/base'
require_rel 'status_cat/checkers'

module StatusCat

  def self.config
    return StatusCat::Config.instance
  end

  def self.configure
    yield config
  end
end
