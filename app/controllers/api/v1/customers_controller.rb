class Api::V1::CustomersController < ApplicationController
  def home
    render 'home.json'
  end

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
    render json: Customer.find_by(formatted_params)
  end

  def find_all
    render json: Customer.where(formatted_params)
  end

  def invoices
    render json: Customer.find(params[:id]).invoices
  end

  def transactions
    render json: Customer.find(params[:id]).transactions
  end

  def favorite_merchant
    render json: Customer.find(params[:id]).favorite_merchant
  end

  private
    ATTRIBUTES = %w[id first_name last_name created_at updated_at name]

    def formatted_params
      params.has_key?("name") ? full_name : find_param(ATTRIBUTES)
    end

    def full_name
      full_name = params["name"].split(" ")
      [:first_name, :last_name].zip(full_name).to_h
    end
end
