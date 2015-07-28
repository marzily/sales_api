require 'test_helper'

class InvoiceItemTest < ActiveSupport::TestCase
  def setup
    @invoice_item = InvoiceItem.new(item_id: 539, invoice_id: 1, quantity: 5, unit_price: 13635)
  end

  test "it must have an item id" do
    @invoice_item.respond_to?(:item)
    @invoice_item.item_id = nil
    refute @invoice_item.valid?
  end

  test "it must have an invoice id" do
    @invoice_item.respond_to?(:invoice)
    @invoice_item.invoice_id = nil
    refute @invoice_item.valid?
  end

  test "can create a valid invoice item" do
    assert @invoice_item.valid?
  end
end
