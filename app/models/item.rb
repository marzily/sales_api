class Item < ActiveRecord::Base
  # default_scope { where(updated_at: Time.now) }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :merchant_id, presence: true

  def self.random
    id = rand(1..Item.count)
    Item.find(id)
  end

  def self.most_revenue
    invoice_items.sum("quantity * unit_price")
  end
end
