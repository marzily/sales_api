class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def random
    # byebug
    merchant = Merchant.random
    respond_with merchant
    # respond_with merchant.items

  end
end
