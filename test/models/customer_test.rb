require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  def setup
    @customer = Customer.new(first_name: "Amelia", last_name: "Reynolds")
  end

  test "first name must be present" do
    @customer.first_name = ""
    refute @customer.valid?
  end

  test "last name must be present" do
    @customer.last_name = ""
    refute @customer.valid?
  end

  test "customer can be created with a first name and a last name" do
    assert @customer.valid?
  end

  test "customer has many invoices" do
    assert @customer.respond_to?(:invoices)
  end

  test "customer has many transactions" do
    assert @customer.respond_to?(:transactions)
  end
end
