Rails.application.routes.draw do
  root "api/v1/static_pages#home"

  namespace :api do
    namespace :v1 do

    # BUSINESS INTELLIGENCE
      # all merchants
      get "/merchants/most_revenue", to: "merchants#most_revenue"
      get "/merchants/most_items",   to: "merchants#most_items"
      # get "/merchants/revenue",      to: "merchants#revenue"#?date=x" returns the total revenue for date x across all merchants

      # all items
      get "/items/most_revenue", to: "items#most_revenue"
      get "/items/most_items",   to: "items#most_items"


    # ENDPOINT ROUTES
      model_objects = ["customers", "merchants", "items", "invoices", "invoice_items", "transactions"]
      model_objects.each do |model_object|
        get "/#{model_object}/random",   to: "#{model_object}#random"
        get "/#{model_object}/find",     to: "#{model_object}#find"
        get "/#{model_object}/find_all", to: "#{model_object}#find_all"
        get "/#{model_object}/:id",      to: "#{model_object}#show"
        get "/#{model_object}",          to: "#{model_object}#index"
      end


    # BUSINESS INTELLIGENCE
      # a single merchant
      get "/merchants/:id/revenue", to: "merchants#single_total_revenue"
      get "/merchants/:id/favorite_customer", to: "merchants#favorite_customer"
      get "/merchants/:id/customers_with_pending_invoices", to: "merchants#customers_with_pending_invoices"

      # a single item
      get "/items/:id/best_day", to: "items#best_day"

      # a single customer
      get "/customers/:id/favorite_merchant", to: "customers#favorite_merchant"


    # RELATIONSHIP ROUTES
      # merchant relationships
      get "/merchants/:id/items",    to: "merchants#items"
      get "/merchants/:id/invoices", to: "merchants#invoices"

      # invoice relationships
      get "/invoices/:id/transactions", to: "invoices#transactions"
      get "invoices/:id/invoice_items", to: "invoices#invoice_items"
      get "/invoices/:id/items",        to: "invoices#items"
      get "/invoices/:id/customer",     to: "invoices#customer"
      get "/invoices/:id/merchant",     to: "invoices#merchant"

      # invoice_item relationships
      get "/invoice_items/:id/invoice", to: "invoice_items#invoice"
      get "/invoice_items/:id/item",    to: "invoice_items#item"

      # item relationships
      get "/items/:id/invoice_items", to: "items#invoice_items"
      get "/items/:id/merchant",      to: "items#merchant"

      # transaction relationships
      get "/transactions/:id/invoice", to: "transactions#invoice"

      # customer relationships
      get "/customers/:id/invoices",     to: "customers#invoices"
      get "/customers/:id/transactions", to: "customers#transactions"
    end
  end

end
