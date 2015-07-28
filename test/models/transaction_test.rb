require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  def setup
    @transaction = Transaction.new(invoice_id: 1, credit_card_number: "4654405418249632", credit_card_expiration_date: nil, result: "success")
  end

  test "it must belong to an invoice" do
    @transaction.invoice_id = nil
    assert @transaction.respond_to?(:invoice)
    refute @transaction.valid?
  end

  test "it must have a credit card number" do
    @transaction.credit_card_number = nil
    refute @transaction.valid?
  end

  test "it must have a result" do
    @transaction.result = nil
    refute @transaction.valid?
  end

  test "can create a valid transaction" do
    assert @transaction.valid?
  end
end
