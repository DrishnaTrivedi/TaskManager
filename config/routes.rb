require 'letter_opener_web'

Rails.application.routes.draw do 
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?  
  namespace :api do                 
    namespace :v1 do               
      resources :users, only: [:create, :show, :update, :destroy] do  
        resources :tasks, only: [:index, :create, :show, :update, :destroy]
      end   
    end     
  end       
end         