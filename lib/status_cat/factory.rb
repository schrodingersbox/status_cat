# StatusCat::Checker factory

class StatusCat::Factory

  def self.all
    return [
      StatusCat::Checkers::ActionMailerChecker.new,
      StatusCat::Checkers::ActiveRecordChecker.new
    ]
  end

  def self.check( name )
    ( 'StatusCat::Checkers::' + name.to_s.classify + 'Checker' ).constantize.new
  end


end
