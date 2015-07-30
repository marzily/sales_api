class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def self.random
    id = rand(1..Customer.count)
    Customer.find(id)
  end

  def successful_invoices
    invoices.joins(:transactions).where("transactions.result = ?", "success")
  end

  def favorite_merchant
    merchant_invoices = successful_invoices.group_by { |invoice| invoice.merchant_id }
    merchant_id = merchant_invoices.max_by { |merchant_id, invoices| invoices.count }.first
    Merchant.find(merchant_id)
  end
end
