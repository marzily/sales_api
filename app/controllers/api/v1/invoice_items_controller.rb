class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def random
    respond_with InvoiceItem.random
  end

  def show
    respond_with InvoiceItem.find(params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(find_param)
  end

  def find_all
    respond_with InvoiceItem.where(find_param.keys.first => find_param.values.first)
  end

  private

    def find_param
      attributes = %w[id item_id invoice_id quantity unit_price created_at updated_at]
      params.select { |key, value| attributes.include?(key) }
    end
end
