class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def random
    respond_with Item.random
  end

  def show
    respond_with Item.find(params[:id])
  end

  def find
    respond_with Item.find_by(find_param)
  end

  def find_all
    respond_with Item.where(find_param.keys.first => find_param.values.first)
  end

  private

    def find_param
      attributes = %w[id name description unit_price merchant_id created_at updated_at]
      params.select { |key, value| attributes.include?(key) }
    end
end
