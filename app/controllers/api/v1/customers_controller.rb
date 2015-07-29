class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def random
    respond_with Customer.random
  end

  def show
    respond_with Customer.find(params[:id])
  end

  def index
    respond_with Customer.all
  end

  def find
    render json: Customer.find_by(find_param)
  end

  def find_all
    render json: Customer.where(find_param)
  end

  private

    def find_param
      params.has_key?("name") ? full_name : keys_to_sym
    end

    def full_name
      full_name = params["name"].split(" ")
      [:first_name, :last_name].zip(full_name).to_h
    end

    def keys_to_sym
      attributes = %w[id first_name last_name created_at updated_at name]
      attributes.each do |attribute|
        if params.has_key?(attribute)
          return { attribute.to_sym => params[attribute] }
        end
      end
    end
end
