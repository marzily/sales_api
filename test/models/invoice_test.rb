require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  test "it must belong to a customer" do
    invoice = Invoice.new(customer_id: nil, merchant_id: 1, status: "shipped")
    assert invoice.respond_to?(:customer)
    refute invoice.valid?
  end

  test "it must belong to a merchant" do
    invoice = Invoice.new(customer_id: 1, merchant_id: nil, status: "shipped")
    assert invoice.respond_to?(:merchant)
    refute invoice.valid?
  end

  test "it must have a status" do
    invoice = Invoice.new(customer_id: 1, merchant_id: 1, status: "")
    refute invoice.valid?
  end

  def setup
    @invoice = Invoice.new(customer_id: 1, merchant_id: 1, status: "shipped")
  end

  test "can create a valid invoice" do
    assert @invoice.valid?
  end

  test "it has many invoice items" do
    assert @invoice.respond_to?(:invoice_items)
  end

  test "it has many items" do
    assert @invoice.respond_to?(:items)
  end

  test "it has many transactions" do
    assert @invoice.respond_to?(:transactions)
  end
end
