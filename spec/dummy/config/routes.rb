Rails.application.routes.draw do

  mount StatusCat::Engine => '/status_cat'

  root :to => 'root#index'
  get '/mail' => 'root#mail'
end
