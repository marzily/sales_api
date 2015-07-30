class Api::V1::InvoiceItemsController < ApplicationController
  def random
    render json: InvoiceItem.random
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end

  def index
    render json: InvoiceItem.all
  end

  def find
    render json: InvoiceItem.find_by(find_param(ATTRIBUTES))
  end

  def find_all
    render json: InvoiceItem.where(find_param(ATTRIBUTES))
  end

  def invoice
    render json: InvoiceItem.find(params[:id]).invoice
  end

  def item
    render json: InvoiceItem.find(params[:id]).item
  end

  private
    ATTRIBUTES = %w[id item_id invoice_id quantity unit_price created_at updated_at]
end
