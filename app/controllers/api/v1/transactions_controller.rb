class Api::V1::TransactionsController < ApplicationController
  def random
    render json: Transaction.random
  end

  def show
    render json: Transaction.find(params[:id])
  end

  def index
    render json: Transaction.all
  end

  def find
    render json: Transaction.find_by(find_param(ATTRIBUTES))
  end

  def find_all
    render json: Transaction.where(find_param(ATTRIBUTES))
  end

  def invoice
    render json: Transaction.find(params[:id]).invoice
  end

  private
    ATTRIBUTES = %w[id invoice_id credit_card_number result created_at updated_at]
end
