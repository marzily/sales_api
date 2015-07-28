class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def random
    respond_with Invoice.random
  end

  def show
    respond_with Invoice.find(params[:id])
  end

  def find
    respond_with Invoice.find_by(find_param)
  end

  def find_all
    respond_with Invoice.where(find_param.keys.first => find_param.values.first)
  end

  private

    def find_param
      attributes = %w[id customer_id merchant_id status created_at updated_at]
      params.select { |key, value| attributes.include?(key) }
    end
end
