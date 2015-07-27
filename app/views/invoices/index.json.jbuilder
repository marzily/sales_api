json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :customer_id, :merchant_id, :status
  json.url invoice_url(invoice, format: :json)
end
