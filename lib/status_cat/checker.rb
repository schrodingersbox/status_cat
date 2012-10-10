# checker.rb
#
# Base class for all status checkers

class StatusCat::Checker

  # Class Methods

  def self.all
    return [
      StatusCat::Checkers::ActionMailerChecker.new,
      StatusCat::Checkers::ActiveRecordChecker.new
    ]
  end

  # Instance methods

  def name
    raise 'Unimplemented'
  end

  def value
    raise 'Unimplemented'
  end

  def status
    raise 'Unimplemented'
  end

protected

  def fail_on_exception
    begin
      yield
    rescue Exception => e
      return e
    end

    return nil
  end

end
