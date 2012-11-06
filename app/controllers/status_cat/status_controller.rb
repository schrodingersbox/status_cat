class StatusCat::StatusController < ApplicationController

  def index
    @checkers = StatusCat::Status.all
  end

end