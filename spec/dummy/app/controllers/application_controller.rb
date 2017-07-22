class ApplicationController < ActionController::Base

  protect_from_forgery

  def authenticate!
    render text: 'forbidden' unless cookies[:login]
  end

  def authorize!
  end
end
