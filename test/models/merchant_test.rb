require 'test_helper'

class MerchantTest < ActiveSupport::TestCase
  def setup
    @merchant = Merchant.new(name: "Klein, Rempel and Jones")
  end

  test "merchant must have a name" do
    @merchant.name = ""
    refute @merchant.valid?
  end

  test "merchant is valid with a name" do
    assert @merchant.valid?
  end

  test "merchant has many invoices" do
    assert @merchant.respond_to?(:invoices)
  end

  test "merchant has many items" do
    assert @merchant.respond_to?(:items)
  end
end
