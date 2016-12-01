Rails.application.routes.draw do
  resources :help

  resources :farms do
  	resources :fertilizers, :bananas
  end
 
  root 'welcome#index'
end
