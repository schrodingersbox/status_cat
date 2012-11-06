class RootController < ApplicationController

  def index
  end

  def mail
    StatusCat::StatusMailer.failure( StatusCat::Status.all ).deliver
  end

end