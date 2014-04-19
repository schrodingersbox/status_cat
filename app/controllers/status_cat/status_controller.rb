class StatusCat::StatusController < ApplicationController

  layout :set_layout

  before_filter :_authenticate!
  before_filter :_authorize!

  def index
    @checkers = StatusCat::Status.all
  end

private

  def set_layout
    return StatusCat.config.layout
  end

  def _authenticate!
    instance_eval( &StatusCat.config.authenticate_with )
  end

  def _authorize!
    instance_eval( &StatusCat.config.authorize_with )
  end

end