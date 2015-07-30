class Api::V1::ItemsController < ApplicationController
  def random
    render json: Item.random
  end

  def show
    render json: Item.find(params[:id])
  end

  def index
    render json: Item.all
  end

  def find
    render json: Item.find_by(find_param(ATTRIBUTES))
  end

  def find_all
    render json: Item.where(find_param(ATTRIBUTES))
  end

  def invoice_items
    render json: Item.find(params[:id]).invoice_items
  end

  def merchant
    render json: Item.find(params[:id]).merchant
  end

  def most_revenue
    render json: Item.sort_by_most_revenue(params[:quantity])
  end

  def most_items
    render json: Item.sort_by_most_items(params[:quantity])
  end

  def best_day
   render json: Item.find(params[:id]).best_day
  end

  private
    ATTRIBUTES = %w[id name description unit_price merchant_id created_at updated_at]
end
