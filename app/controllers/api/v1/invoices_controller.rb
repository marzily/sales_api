class Api::V1::InvoicesController < ApplicationController
  def random
    render json: Invoice.random
  end

  def show
    render json: Invoice.find(params[:id])
  end

  def index
    render json: Invoice.all
  end

  def find
    render json: Invoice.find_by(find_param(ATTRIBUTES))
  end

  def find_all
    render json: Invoice.where(find_param(ATTRIBUTES))
  end

  def transactions
    render json: Invoice.find(params[:id]).transactions
  end

  def invoice_items
    render json: Invoice.find(params[:id]).invoice_items
  end

  def items
    render json: Invoice.find(params[:id]).items
  end

  def customer
    render json: Invoice.find(params[:id]).customer
  end

  def merchant
    render json: Invoice.find(params[:id]).merchant
  end

  private
    ATTRIBUTES = %w[id customer_id merchant_id status created_at updated_at]
end
