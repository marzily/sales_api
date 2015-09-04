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

  def pending_invoices
    invoices.where(status: "pending")
  end

  def total_revenue_in_dollars(invoices)
    invoices.inject(0) { |sum, invoice| sum += invoice.invoice_total } / 100.00
  end

  def total_revenue(date)
    return total_revenue_in_dollars(successful_invoices) if date.nil?

    dated_invoices = successful_invoices.where(updated_at: date)
    total_revenue_in_dollars(dated_invoices)
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

  def successful_invoices_by_date(date)
    successful_invoices.where(updated_at: date)
  end

  def favorite_customer
    grouped_invoices = successful_invoices.group_by(&:customer_id)
    customer_id = grouped_invoices.max_by { |customer_id, invoices| invoices.count }.first
    Customer.find(customer_id)
  end

  def customers_with_pending_invoices
    pending_invoices.map { |invoice| Customer.find(invoice.customer_id) }.uniq
  end
end
