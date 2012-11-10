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

  # Emails ::failed list if it is not empty
  def self.cron
    checkers = self.failed
    StatusCat::StatusMailer.failure( checkers ).deliver unless checkers.empty?
  end


  # Constructs a checker instance given it's name
  def self.factory( name )
    ( 'StatusCat::Checkers::' + name.to_s.classify ).constantize.new
  end

  # Returns an array of failed instances of ::all
  def self.failed
    self.all.map { |checker| checker.status.nil? ? nil : checker }.compact
  end

end
