class StatusCat::StatusMailer <  ActionMailer::Base

  add_template_helper( StatusCat::StatusHelper )

  def failure( checkers )
    @checkers = checkers

    config = StatusCat.config
    mail( :to => config.to, :from => config.from, :subject => config.subject )
  end

end