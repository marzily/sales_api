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
    render json: Item.find_by(find_param)
  end

  def find_all
    render json: Item.where(find_param)
  end

  def invoice_items
    render json: Item.find(params[:id]).invoice_items
  end

  def merchant
    render json: Item.find(params[:id]).merchant
  end

  def most_revenue
    render json: Item.sort_by_most_revenue(params[:quantity].to_i)
  end

  def most_items
    render json: Item.sort_by_most_items(params[:quantity].to_i)
    #  ?quantity=x returns the top x item instances ranked by total number sold
  end

  def best_day
   render json: Item.find(params[:id]).best_day
  end

  private

    def find_param
      attributes = %w[id name description unit_price merchant_id created_at updated_at]
      attributes.each do |attribute|
        if params.has_key?(attribute)
          return { attribute.to_sym => params[attribute] }
        end
      end
    end
end
