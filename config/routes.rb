StatusCat::Engine.routes.draw do
  root :to => 'status#index'
  match '/status' =>  'status#index'
end
