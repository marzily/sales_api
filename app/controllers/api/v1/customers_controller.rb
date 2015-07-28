class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def random
    respond_with Customer.random
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def find
    respond_with Customer.find_by(find_param)
  end

  def find_all
    respond_with Customer.where(find_param.keys.first => find_param.values.first)
  end

  private

    def find_param
      attributes = %w[id first_name last_name created_at updated_at]
      params.select { |key, value| attributes.include?(key) }
    end
end
