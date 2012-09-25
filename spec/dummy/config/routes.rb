Rails.application.routes.draw do

  mount StatusCat::Engine => "/status-cat"
end
