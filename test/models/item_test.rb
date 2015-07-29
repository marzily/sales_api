require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "item must have a name" do
    item = Item.new(name: "", description: "pink", unit_price: 1, merchant_id: 1)
    refute item.valid?
  end

  test "item must have a description" do
    item = Item.new(name: "frisbee", description: "", unit_price: 1, merchant_id: 1)
    refute item.valid?
  end

  test "item must have a unit price" do
    item = Item.new(name: "frisbee", description: "pink", unit_price: nil, merchant_id: 1)
    refute item.valid?
  end

  test "item belongs to a merchant" do
    item = Item.new(name: "frisbee", description: "pink", unit_price: 1, merchant_id: nil)
    assert item.respond_to?(:merchant)
    refute item.valid?
  end

  test "can create valid item" do
    item = Item.new(name: "frisbee", description: "pink", unit_price: 1, merchant_id: 1)
    assert item.valid?
  end

  test "item has many invoice items" do
    item = Item.new(name: "frisbee", description: "pink", unit_price: 1, merchant_id: 1)
    assert item.respond_to?(:invoice_items)
  end

  test "item has many invoices" do
    item = Item.new(name: "frisbee", description: "pink", unit_price: 1, merchant_id: 1)
    assert item.respond_to?(:invoices)
  end
end
