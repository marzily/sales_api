class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  validates :name, presence: true

  def self.random
    id = rand(1..Merchant.count)
    merchant = Merchant.find(id)
  end

  def successful_invoices
    invoices.joins(:transactions).where("transactions.result = ?", "success")
  end

  def total_revenue
    successful_invoices.inject(0) { |sum, invoice| sum += invoice.invoice_total }
  end

  def self.sorted_by_most_revenue(num)
    all.max_by(num) { |merchant| merchant.total_revenue }
  end

  def total_items
    successful_invoices.inject(0) { |sum, invoice| sum += invoice.total_num_items }
  end

  def self.sorted_by_most_items(num)
    all.max_by(num) { |merchant| merchant.total_items }
  end

  def self.revenue_on_date(date)
    Invoice
    merchants.map
    #?date=x" returns the total revenue for date x across all merchants
  end
end
