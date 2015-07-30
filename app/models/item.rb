class Item < ActiveRecord::Base

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

  def successful_invoices
    invoices.joins(:transactions).where("transactions.result = ?", "success")
  end

  def successfully_sold_quantity
    successful_invoices.flat_map do |successful_invoice|
      successful_invoice.invoice_items.select { |invoice_item| invoice_item.item_id == id }
    end.count
  end

  def self.sort_by_most_revenue(num)
    all.max_by(num) { |item| item.successfully_sold_quantity * item.unit_price }
  end

  def self.sort_by_most_items(num)
    all.max_by(num) { |item| item.successfully_sold_quantity }
  end

  def best_day
    grouped_invoices = successful_invoices.group_by { |invoice| invoice.updated_at.to_date }
    grouped_invoices.max_by { |date, invoices| invoices.count }.first
  end
end
