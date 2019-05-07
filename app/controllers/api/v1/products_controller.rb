class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorize_request, only: :index
  def index
    render json: Product.all.to_json
  end
end
