# StatusCat::Checker factory

class StatusCat::Status

  def self.all
    return [
      StatusCat::Checkers::ActionMailerChecker.new,
      StatusCat::Checkers::ActiveRecordChecker.new
    ]
  end

end
