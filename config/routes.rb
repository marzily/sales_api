Rails.application.routes.draw do

  model_objects = ["customers", "merchants", "items", "invoices", "invoice_items", "transactions"]

  model_objects.each do |model_object|
    namespace :api do
      namespace :v1 do
        get "/#{model_object}/random", to: "#{model_object}#random"
        get "/#{model_object}/find", to: "#{model_object}#find"
        get "/#{model_object}/find_all", to: "#{model_object}#find_all"
        get "/#{model_object}/:id", to: "#{model_object}#show"
      end
    end
  end
  
end
