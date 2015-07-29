Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      # endpoints
      model_objects = ["customers", "merchants", "items", "invoices", "invoice_items", "transactions"]
      model_objects.each do |model_object|
        get "/#{model_object}/random",   to: "#{model_object}#random"
        get "/#{model_object}/find",     to: "#{model_object}#find"
        get "/#{model_object}/find_all", to: "#{model_object}#find_all"
        get "/#{model_object}/:id",      to: "#{model_object}#show"
        get "/#{model_object}",          to: "#{model_object}#index"
      end

      # merchant relationships
      get "/merchants/:id/items",    to: "merchants#items"
      get "/merchants/:id/invoices", to: "merchants#invoices"

      # invoice relationships
      get "/invoices/:id/transactions", to: "invoices#transactions"
      get "invoices/:id/invoice_items", to: "invoices#invoice_items"
      get "/invoices/:id/items",        to: "invoices#items"
      get "/invoices/:id/customer",     to: "invoices#customer"
      get "/invoices/:id/merchant",     to: "invoices#merchant"
    end
  end

end
