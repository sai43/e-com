class Api::V1::ProductsController < ApplicationController
  def index
    render json: Product.all.to_json
  end
end
