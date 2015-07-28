namespace :seed do
  desc "Read customer data from CSV to db"
  task :customer => :environment do
    require 'csv'
    file_path = "./lib/assets/data/customers.csv"
    csv = CSV.parse(file_path, headers: true, header_converters: :symbol)
    csv.each do |row|
      Customer.create!(row.to_h)
    end
  end

  desc "Read customer data from CSV to db"
  task :customer => :environment do
    require 'csv'
    file_path = "./lib/assets/data/customers.csv"
    csv = CSV.parse(file_path, headers: true, header_converters: :symbol)
    csv.each do |row|
      Customer.create!(row.to_h)
    end
  end


end
