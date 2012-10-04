Rails.application.routes.draw do

  mount StatusCat::Engine => '/status-cat'

  root :to => 'root#index'
end
