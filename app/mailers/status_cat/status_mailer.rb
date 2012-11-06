class StatusCat::StatusMailer <  ActionMailer::Base

  add_template_helper( StatusCat::StatusHelper )

  def failure( checkers )
    @checkers = checkers

    config = StatusCat.config
    mail( :to => config.email_to, :from => config.email_from, :subject => config.email_subject )
  end

end