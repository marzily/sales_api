class Customer < ActiveRecord::Base
  has_many :invoices

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def self.random
    id = rand(1..Customer.count)
    Customer.find(id)
  end
end
