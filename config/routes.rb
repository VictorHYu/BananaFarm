Rails.application.routes.draw do
    resources :help
    
    resources :farms do
        resources :bananas do
            patch 'add'
            patch 'remove'
        end
    end
    
    root 'welcome#index'
end
