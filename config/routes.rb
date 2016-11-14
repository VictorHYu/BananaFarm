Rails.application.routes.draw do
  resources :bananas
 
  root 'welcome#index'
end
