require 'csv'

namespace :seed do
  model_objects = ["customer", "merchant", "item", "invoice", "invoice_item", "transaction"]

  model_objects.each do |model_object|

    desc "Read #{model_object} data from CSV to db"
    task model_object.to_sym => :environment do

      file_path = "./lib/assets/data/#{model_object}s.csv"
      csv = CSV.read(file_path, headers: true)
      csv.each do |row|
        if model_object == "invoice_item"
          class_name = model_object.split("_").map(&:capitalize).join
          eval(class_name).create!(row.to_h)
        elsif model_object == "transaction"
          eval(model_object.capitalize).create!(row.to_h.except("credit_card_expiration_date"))
        else
          eval(model_object.capitalize).create!(row.to_h)
        end
      end
    end

  end

  desc "Read all data from CSV to db"
  task :all => :environment do
    model_objects.each do |model_object|
      file_path = "./lib/assets/data/#{model_object}s.csv"
      csv = CSV.open(file_path, headers: true)
      csv.each do |row|
        if model_object == "invoice_item"
          class_name = model_object.split("_").map(&:capitalize).join
          eval(class_name).create!(row.to_h)
        elsif model_object == "transaction"
          eval(model_object.capitalize).create!(row.to_h.except("credit_card_expiration_date"))
        else
          eval(model_object.capitalize).create!(row.to_h)
        end
      end
      csv.close
    end
  end

end
