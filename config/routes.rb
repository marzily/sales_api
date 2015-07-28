Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/random', to: "merchants#random"
      get '/merchants/find', to: "merchants#find"
      get '/merchants/find_all', to: "merchants#find_all"
      get '/merchants/:id', to: "merchants#show"
    end
  end
end
