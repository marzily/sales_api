class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  validates :item_id, presence: true
  validates :invoice_id, presence: true
end
