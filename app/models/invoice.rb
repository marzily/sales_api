class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status, presence: true

  def self.random
    id = rand(1..Invoice.count)
    Invoice.find(id)
  end

  def self.successful_on_date(date)
    joins(:transactions)
    .where("transactions.result = ?", "success")
    .where(updated_at: date)
  end

  def invoice_total
    invoice_items.inject(0) do |total, invoice_item|
      total += (invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def total_num_items
    invoice_items.inject(0) { |sum, invoice_item| sum += invoice_item.quantity }
  end
end
