class Api::V1::MerchantsController < ApplicationController
  def random
    render json: Merchant.random
  end

  def show
    render json: Merchant.find(params[:id])
  end

  def index
    render json: Merchant.all
  end

  def find
    render json: Merchant.find_by(find_param)
  end

  def find_all
    render json: Merchant.where(find_param)
  end

  def items
    render json: Merchant.find(params[:id]).items
  end

  def invoices
    render json: Merchant.find(params[:id]).invoices
  end

  def most_revenue
    render json: Merchant.sorted_by_most_revenue(params[:quantity].to_i)
  end

  def most_items
    render json: Merchant.sorted_by_most_items(params[:quantity].to_i)
  end

  private

    def find_param
      attributes = %w[id name created_at updated_at]
      attributes.each do |attribute|
        if params.has_key?(attribute)
          return { attribute.to_sym => params[attribute] }
        end
      end
    end
end
