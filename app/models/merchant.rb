class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  validates :name, presence: true

  def self.random
    id = rand(1..Merchant.count)
    merchant = Merchant.find(id)
    { merchant: merchant, invoices: merchant.invoice_ids, items: merchant.item_ids }
  end

  def invoice_ids
    invoices.map(&:id)
  end

  def item_ids
    items.map(&:id)
  end
end
