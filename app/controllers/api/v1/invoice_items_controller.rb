class Api::V1::InvoiceItemsController < ApplicationController
  def random
    render json: InvoiceItem.random
  end

  def show
    render json: InvoiceItem.find(params[:id])
  end

  def index
    render json: InvoiceItem.all
  end

  def find
    render json: InvoiceItem.find_by(find_param)
  end

  def find_all
    render json: InvoiceItem.where(find_param)
  end

  private

    def find_param
      attributes = %w[id item_id invoice_id quantity unit_price created_at updated_at]
      attributes.each do |attribute|
        if params.has_key?(attribute)
          return { attribute.to_sym => params[attribute] }
        end
      end
    end
end
