Rails.application.routes.draw do   
  namespace :api do                 
    namespace :v1 do               
      resources :users, only: [:create, :show, :update, :destroy] do  
        resources :tasks, only: [:index, :create, :show, :update, :destroy]
      end   
    end     
  end       
end         