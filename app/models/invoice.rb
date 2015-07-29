class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true

  # scope :successful, -> { joins(:transactions).where("transactions.result = ?", "success") }

  def self.random
    id = rand(1..Invoice.count)
    Invoice.find(id)
  end

  def invoice_total
    invoice_items.inject(0) do |total, invoice_item|
      total += invoice_item.quantity * invoice_item.unit_price
      total
    end
  end
end
