Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      model_objects = ["customers", "merchants", "items", "invoices", "invoice_items"]
      model_objects.each do |model_object|
        get "/#{model_object}/random", to: "#{model_object}#random"
        get "/#{model_object}/find", to: "#{model_object}#find"
        get "/#{model_object}/find_all", to: "#{model_object}#find_all"
        get "/#{model_object}/:id", to: "#{model_object}#show"
      end

      get "/merchants/:id/items", to: "merchants#items"
      get "/merchants/:id/invoices", to: "merchants#invoices"
    end
  end

# merchant items
# merchant invoices

  # def generate_endpoint_routes
  #   model_objects = ["customers", "merchants", "items", "invoices", "invoice_items"]
  #   model_objects.each do |model_object|
  #     get "/#{model_object}/random", to: "#{model_object}#random"
  #     get "/#{model_object}/find", to: "#{model_object}#find"
  #     get "/#{model_object}/find_all", to: "#{model_object}#find_all"
  #     get "/#{model_object}/:id", to: "#{model_object}#show"
  #   end
  # end

end
