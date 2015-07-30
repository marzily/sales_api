class ChangeUnitPriceDatatypeForInvoiceItems < ActiveRecord::Migration
  def change
    remove_column :invoice_items, :unit_price, :string
    add_column :invoice_items, :unit_price, :decimal
  end
end
