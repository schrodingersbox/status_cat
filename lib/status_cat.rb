require 'require_all'
require_rel 'status_cat'

module StatusCat

  def self.config
    return StatusCat::Config.instance
  end

  def self.configure
    yield config
  end
end
