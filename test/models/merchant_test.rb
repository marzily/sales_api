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
end
