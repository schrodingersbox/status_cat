class StatusCat::StatusController < StatusCat::ApplicationController

  def index
    render :text => 'Hello world!'
  end

end