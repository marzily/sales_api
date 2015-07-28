Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/merchants/random', to: "merchants#random"
    end
  end
end
