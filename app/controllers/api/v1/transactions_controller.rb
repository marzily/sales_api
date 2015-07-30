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
    render json: Transaction.find_by(find_param)
  end

  def find_all
    render json: Transaction.where(find_param)
  end

  def invoice
    render json: Transaction.find(params[:id]).invoice
  end

  private

    def find_param
      attributes = %w[id invoice_id credit_card_number result created_at updated_at]
      attributes.each do |attribute|
        if params.has_key?(attribute)
          return { attribute.to_sym => params[attribute] }
        end
      end
    end
end
