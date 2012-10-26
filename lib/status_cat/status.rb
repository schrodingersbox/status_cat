# StatusCat::Status

class StatusCat::Status

  def self.all
    StatusCat::Checkers::Base.descendants.sort { |a,b| a.to_s <=> b.to_s }.map { |c| c.new }
  end

  def self.check( which = :all )
    return all if which == :all
    return factory( which ) unless which.is_a?( Array )
    return which.map { |name| factory( name ) }
  end

  def self.factory( name )
    ( 'StatusCat::Checkers::' + name.to_s.classify ).constantize.new
  end

end
