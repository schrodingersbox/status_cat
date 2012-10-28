# StatusCat::Status

class StatusCat::Status

  # Returns an array of instances of all StatusCat::Checkers::Base subclasses

  def self.all
    StatusCat::Checkers::Base.descendants.sort { |a,b| a.to_s <=> b.to_s }.map { |c| c.new }
  end

  # By default, returns all checkers
  # If given a list of checker names, returns an array of those checkers
  # If given a single checker name, just returns that checker

  def self.check( which = :all )
    return all if which == :all
    return factory( which ) unless which.is_a?( Array )
    return which.map { |name| factory( name ) }
  end

  # Constructs a checker instance given it's name

  def self.factory( name )
    ( 'StatusCat::Checkers::' + name.to_s.classify ).constantize.new
  end

  # Constructs a text status report

  def self.report( which = :all )
    checkers = check( which )
    checkers = [ checkers ] unless checkers.is_a?( Array )

    name_max = checkers.map { |c| c.name.to_s.length }.max
    value_max = checkers.map { |c| c.value.to_s.length }.max
    status_max = checkers.map { |c| c.status.to_s.length }.max

    format = "%#{name_max}s | %#{value_max}s | %#{status_max}s\n"
    length = name_max + 3 +  value_max + 3 + status_max
    separator = ( '-' * length ) + "\n"

    name = I18n.t( :name, :scope => :status_cat )
    value = I18n.t( :value, :scope => :status_cat )
    status = I18n.t( :status, :scope => :status_cat )

    result = separator.dup
    result << sprintf( format, name, value, status )
    result << separator
    checkers.each { |checker| result << checker.to_s( format ) }
    result << separator

    return result
  end

end
