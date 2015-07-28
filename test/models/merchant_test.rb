require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  test "merchant must have a name" do
    merchant = Merchant.new(name: "")
    refute merchant.valid?
  end

  test "merchant is valid with a name" do
    merchant = Merchant.new(name: "Klein, Rempel and Jones")
    assert merchant.valid?
  end

  test "merchant has many invoices" do
    merchant = Merchant.new(name: "Klein, Rempel and Jones")
    assert merchant.respond_to?(:invoices)
  end

  test "merchant has many items" do
    merchant = Merchant.new(name: "Klein, Rempel and Jones")
    assert merchant.respond_to?(:items)
  end
end
