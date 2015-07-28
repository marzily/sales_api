class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def random
    respond_with Merchant.random
  end

  def show
    respond_with Merchant.find(params[:id])
  end

  def find
    respond_with Merchant.find_by(find_param.keys.first => find_param.values.first)
  end

  def find_all
    respond_with Merchant.where(find_param.keys.first => find_param.values.first)
  end

# GET /api/v1/merchants/find_all?name=Cummings-Thiel

  private

    def find_param
      params.reject { |key, value| key == "controller" || key == "action" }
    end
end
