class AddCcedToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :credit_card_expiration_date, :string
  end
end
