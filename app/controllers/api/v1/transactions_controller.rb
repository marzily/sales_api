class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def random
    respond_with Transaction.random
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def index
    respond_with Transaction.all
  end

  def find
    render json: Transaction.find_by(find_param)
  end

  def find_all
    render json: Transaction.where(find_param.keys.first => find_param.values.first)
  end

  private

    def find_param
      attributes = %w[id invoice_id credit_card_number credit_card_expiration_date result created_at updated_at]
      params.select { |key, value| attributes.include?(key) }
    end
end
