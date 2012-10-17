# checker.rb
#
# Base class for all status checkers

class StatusCat::Checker

  attr_reader :name, :value, :status

  # Class Methods

  def self.all
    return [
      StatusCat::Checkers::ActionMailerChecker.new,
      StatusCat::Checkers::ActiveRecordChecker.new
    ]
  end

  # Instance methods

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
