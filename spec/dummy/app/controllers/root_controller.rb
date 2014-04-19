class RootController < ApplicationController

  def index
  end

  def mail
    StatusCat::StatusMailer.failure( StatusCat::Status.all ).deliver
  end

  def login
    cookies[ :login ] = { :value => true, :expires => 10.years.from_now }
    redirect_to :action => :index
  end

  def logout
    cookies.delete( :login )
    redirect_to :action => :index
  end

end