class Api::V1::CustomersController < ApplicationController
  def random
    render json: Customer.random
  end

  def show
    render json: Customer.find(params[:id])
  end

  def index
    render json: Customer.all
  end

  def find
    render json: Customer.find_by(find_param)
  end

  def find_all
    render json: Customer.where(find_param)
  end

  def invoices
    render json: Customer.find(params[:id]).invoices
  end

  def transactions
    render json: Customer.find(params[:id]).transactions
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
