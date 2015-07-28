require 'csv'

namespace :seed do
  model_objects = ["customer", "merchant", "item", "invoice", "transaction"]
  # "invoice_item"

  model_objects.each do |model_object|

    desc "Read #{model_object} data from CSV to db"
    task model_object.to_sym => :environment do

      file_path = "./lib/assets/data/#{model_object}s.csv"
      csv = CSV.parse(file_path, headers: true, header_converters: :symbol)
      csv.each do |row|
        eval(model_object.capitalize).create!(row.to_h)
      end
    end

  end

  # desc "Read all data from CSV to db"
  # task :all => :environment do
  #   model_objects.each do |model_object|
  #     file_path = "./lib/assets/data/#{model_object}s.csv"
  #     csv = CSV.parse(file_path, headers: true, header_converters: :symbol)
  #     csv.each do |row|
  #       eval(model_object.capitalize).create!(row.to_h)
  #     end
  #   end
  # end

end
