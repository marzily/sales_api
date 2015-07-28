require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "first name must be present" do
    customer = Customer.new(first_name: "", last_name: "Reynolds")
    refute customer.valid?
  end

  test "last name must be present" do
    customer = Customer.new(first_name: "Amelia", last_name: "")
    refute customer.valid?
  end

  test "customer can be created with a first name and a last name" do
    customer = Customer.new(first_name: "Amelia", last_name: "Reynolds")
    assert customer.valid?
  end

  test "customer must have invoices" do
    customer = Customer.new(first_name: "Amelia", last_name: "Reynolds")
    assert customer.respond_to?(:invoices)
  end
end
