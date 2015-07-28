class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  validates :name, presence: true
end
