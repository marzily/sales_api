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
    # first result is same but rest change
  end

  def self.sort_by_most_items(num)
    all.max_by(num) { |item| item.successfully_sold_quantity }
    #  ?quantity=x returns the top x item instances ranked by total number sold
    # first result is same but rest change
  end

  def self.best_day
    successful_invoices.group_by { |invoice| invoice.updated_at }
    # check invoice items
    # group
    # returns the date with the most sales for the given item using the invoice date
  end
end
